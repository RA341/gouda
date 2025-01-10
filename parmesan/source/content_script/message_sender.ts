import {CategoryResponse, MediaResponse, MessageRequest} from "../shared/mesages";
import {browserAPI} from "../shared/browser";
import {getMetadata} from "./metadata";

async function sendMessage(
	message: MessageRequest
): Promise<any> {
	try {
		return await new Promise((resolve, reject) => {
			browserAPI.runtime.sendMessage(message, (response: any) => {
				console.log('Received response', response);
				if (browserAPI.runtime.lastError) {
					reject(new Error(browserAPI.runtime.lastError.message));
				} else {
					resolve(response);
				}
			});
		});
	} catch (error) {
		console.error('Error sending message:', error);
		throw error;
	}
}

export async function isSetupComplete() {
	try {
		const req = await sendMessage({type: 'SETUP_COMPLETE'}) as string
		if (req !== "") {
			console.error(`extension is not setup: ${req}`)
			return false;
		}

		return true;
	} catch (error) {
		console.error('Error sending message:', error);
		return false;
	}
}


export async function sendMediaInfo() {
	const mediaRequest = getMetadata();
	return await sendMessage({type: 'NEW_MEDIA', media: mediaRequest}) as MediaResponse;
}


export async function getCategories() {
	console.log('Getting categories');
	return await sendMessage({type: 'GET_CATEGORIES'}) as CategoryResponse
}

