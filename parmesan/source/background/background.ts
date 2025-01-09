import {browserAPI} from "../shared/browser";
import {BookMetadata, CategoryResponse, MediaResponse, MessageRequest} from "../shared/mesages";
import {AddMediaRequest, Media} from "../gen/media_requests/v1/media_requests_pb";
import {createCategoryClient, createGRPCTransport, createMediaRequestClient} from "../shared/grpc_client";
import {Transport} from "@connectrpc/connect";
import {ListCategoriesRequest} from "../gen/category/v1/category_pb";

let cachedSettings: {
	gouda_baseurl?: string;
	gouda_apikey?: string;
} | null = null;

let transport: Transport | null = null;

// Service worker message listener
browserAPI.runtime.onMessage.addListener((request, _, sendResponse) => {
	// Create an async function to handle the message
	const handleMessage = async (
		message: MessageRequest,
		callback: (response: any) => void
	) => {
		try {
			const data = await getSettings();

			switch (message.type) {
				case 'SETUP_COMPLETE': {
					console.log('Checking if setup complete.');
					const response = (data?.gouda_apikey && data?.gouda_baseurl)
						? ''
						: 'baseurl or api key are missing';
					callback(response);
					break;
				}

				case "GET_CATEGORIES": {
					console.log("Getting categories");
					const resp = await getCategories();
					if (resp.err !== '') {
						console.error(`Unable to fetch categories: ${resp.err}`);
					}
					console.log('Sending categories:', resp);
					callback(resp);
					break;
				}

				case "NEW_MEDIA": {
					const media = message.media;
					console.log(`sending new media request with media ${media}`);
					const res = await sendMedia(media);
					if (res.error !== '') {
						console.error(`Unable to send media request: ${res.error}`);
						callback({error: res.error});
						break;
					}
					callback(media);
					break;
				}

				default:
					callback({error: "Invalid message type"});
			}
		} catch (error) {
			console.error('Error handling message:', error);
			callback({
				error: error instanceof Error ? error.message : 'Unknown error'
			});
		}
	};

	// Execute the async handler and keep the messaging channel open
	handleMessage(request as MessageRequest, sendResponse);
	return true; // Keep the message channel open for the async response
});

// Function to get settings, using cache if available
async function getSettings() {
	if (cachedSettings) {
		return cachedSettings;
	}
	const settings = await browserAPI.storage.sync.get(['gouda_baseurl', 'gouda_apikey']);

	cachedSettings = {
		gouda_baseurl: settings.gouda_baseurl,
		gouda_apikey: settings.gouda_apikey
	};

	if (cachedSettings.gouda_baseurl && cachedSettings.gouda_baseurl) {
		console.debug(`Creating transport with ${cachedSettings!}`)
		transport = createGRPCTransport(cachedSettings!.gouda_baseurl!, cachedSettings!.gouda_apikey!);
	}

	return cachedSettings;
}


async function sendMedia(bookMetadata: BookMetadata): Promise<MediaResponse> {
	try {
		const client = createMediaRequestClient(transport!)

		const media = <Media>{
			author: bookMetadata.author,
			book: bookMetadata.bookName,
			fileLink: bookMetadata.fileLink,
			category: bookMetadata.category,
			mamBookId: BigInt(bookMetadata.mamBookId)
		}

		if (bookMetadata.series != null && bookMetadata.seriesNumber != null) {
			media.series = bookMetadata.series;
			media.seriesNumber = bookMetadata.seriesNumber;
		}

		await client.addMedia(<AddMediaRequest>{media: media})
		return {error: ""}
	} catch (error: any) {
		return {error: error.message.toString()}
	}
}


async function getCategories(): Promise<CategoryResponse> {
	try {
		const categoryClient = createCategoryClient(transport!)
		const categories = (await categoryClient.listCategories(<ListCategoriesRequest>{})).categories

		if (categories.length === 0) {
			return {cat: [], err: 'No Categories found'};
		}

		return {cat: categories.map((e) => e.category), err: ''};
	} catch (error: any) {
		return {cat: [], err: error.toString()};
	}
}

