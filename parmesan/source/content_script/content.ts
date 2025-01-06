import {Transport} from "@connectrpc/connect";
import {browserAPI} from "../shared/browser";
import {getMetadata} from "./metadata";
import {createCategoryClient, createGRPCTransport, createMediaRequestClient} from "../shared/grpc_client";
import {ListCategoriesRequest} from "../gen/category/v1/category_pb";
import {buttonStates, updateButtonState} from "../shared/ui";
import {AddMediaRequest} from "../gen/media_requests/v1/media_requests_pb";
import {showPopup} from "./content_popup";

console.log('💈 Content script loaded for', browserAPI.runtime.getManifest().name);

async function sendInfo(transport: Transport) {
	const mediaClient = createMediaRequestClient(transport)
	const mediaRequest = getMetadata();

	await mediaClient.addMedia(<AddMediaRequest>{media: mediaRequest})
	return {
		bookName: mediaRequest.book,
		author: mediaRequest.author,
		series: mediaRequest.series,
		seriesNumber: mediaRequest.seriesNumber,
		category: mediaRequest.category,
	};
}

async function createDropDown(transport: Transport) {
	const categoryClient = createCategoryClient(transport)

	// Create dropdown
	const dropdown = document.createElement('select');
	dropdown.id = 'gouda_cat'
	dropdown.style.padding = '8px';
	dropdown.style.borderRadius = '4px';

	try {
		const categories = (await categoryClient.listCategories(<ListCategoriesRequest>{})).categories
		categories.forEach(item => {
			const option = document.createElement('option');
			option.value = item.category;
			option.textContent = item.category;
			dropdown.appendChild(option);
		});

		if (categories[0]) {
			dropdown.value = categories[0].category;
		}

		return dropdown;
	} catch (e) {
		console.error(e);
		console.error('Error loading options:', String(e));
		// Add error option
		const errorOption = document.createElement('option');
		errorOption.textContent = 'Error loading options';
		dropdown.appendChild(errorOption);
		return dropdown;
	}
}

async function init() {
	const settings = await browserAPI.storage.sync.get(['gouda_baseurl', 'gouda_apikey']);
	console.log(settings);

	const transport = createGRPCTransport(settings.gouda_baseurl, settings.gouda_apikey);

	const downloadDiv = document.createElement('div');
	downloadDiv.id = 'download';
	downloadDiv.className = 'torDetInnerCon';

	const innerTop = document.createElement('div');
	innerTop.className = 'torDetInnerTop';
	innerTop.textContent = 'Gouda';

	const innerBottom = document.createElement('div');
	innerBottom.className = 'torDetInnerBottom';

	// Create a container for button and dropdown
	const controlsContainer = document.createElement('div');
	controlsContainer.style.display = 'flex';
	controlsContainer.style.gap = '10px';
	controlsContainer.style.alignItems = 'center';

	const goudaButton = document.createElement('a');
	goudaButton.id = 'tddl';
	goudaButton.title = 'Gouda'
	goudaButton.className = 'torFormButton';
	goudaButton.title = 'Send to gouda';
	goudaButton.textContent = 'Parmesan is not setup';
	goudaButton.style.backgroundColor = 'grey';  // Only the button is green
	goudaButton.style.color = 'white';  // White text for contra

	if (settings.gouda_baseurl && settings.gouda_apikey) {
		goudaButton.textContent = 'Send to gouda';
		goudaButton.style.backgroundColor = 'green';  // Only the button is green
		goudaButton.style.color = 'white';  // White text for contra
		goudaButton.onclick = async (ev) => {
			try {
				ev.preventDefault();
				const media = await sendInfo(transport);
				updateButtonState(goudaButton, buttonStates.success);
				showPopup(`Sent to gouda\n\n${JSON.stringify(media)}`, 'success')
			} catch (error) {
				console.log(error)
				updateButtonState(goudaButton, buttonStates.failure);
				showPopup(`Failed to send to gouda, check your apikey and url in settings\n\n\n${error}`, 'error')
			}
		};

		const dropdown = await createDropDown(transport);
		controlsContainer.appendChild(dropdown);
	} else {
		console.log('Could not find base url or apikey');
	}

	// Add elements to the container
	controlsContainer.appendChild(goudaButton);

	// Add the controls container to your existing structure
	innerBottom.appendChild(controlsContainer);
	downloadDiv.appendChild(innerTop);
	downloadDiv.appendChild(innerBottom);

	// Find the uploader div and inject our new element after it
	const uploaderDiv = document.getElementById('uploader')!;
	if (uploaderDiv) {
		uploaderDiv.parentNode!.insertBefore(downloadDiv, uploaderDiv.nextSibling);
	} else {
		console.log('Unable to find torrent details box');
		showPopup('Unable to find torrent details', 'info');
	}
}

init().then(r => {
	console.log('Extension initialized...');
}).catch(e => {
	console.error('Unable to start extension')
	console.error(e);
});
