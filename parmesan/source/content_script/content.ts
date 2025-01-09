import {browserAPI} from "../shared/browser";
import {buttonStates, updateButtonState} from "../shared/ui";
import {showPopup} from "./content_popup";
import {getCategories, isSetupComplete, sendMediaInfo} from "./message_sender";

console.log('💈 Content script loaded for', browserAPI.runtime.getManifest().name);

function createDropDown(categories: string[]) {
	// Create dropdown
	const dropdown = document.createElement('select');
	dropdown.id = 'gouda_cat'
	dropdown.style.padding = '8px';
	dropdown.style.borderRadius = '4px';
	categories.forEach(item => {
		const option = document.createElement('option');
		option.value = item;
		option.textContent = item;
		dropdown.appendChild(option);
	});

	if (categories[0]) {
		dropdown.value = categories[0];
	}

	return dropdown;
}

async function init() {
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

	const isSetup = await isSetupComplete();
	if (isSetup) {
		console.log('Setup is complete')
		const categories = await getCategories();
		console.log(`Categories loaded: ${categories}`)

		if (categories.err !== '') {
			console.error('Error getting categories:', categories.err);
			goudaButton.textContent = 'Unable to find categories';
		} else {
			console.log('Everything is setup setting up button')
			goudaButton.textContent = 'Send to gouda';
			goudaButton.style.backgroundColor = 'green';  // Only the button is green
			goudaButton.style.color = 'white';  // White text for contra
			goudaButton.onclick = async (ev) => {
				try {
					ev.preventDefault();
					const response = await sendMediaInfo();
					if (response.error === "") {
						updateButtonState(goudaButton, buttonStates.success);
						showPopup(`Sent to gouda`, 'success')
					} else {
						updateButtonState(goudaButton, buttonStates.failure);
						showPopup(`Failed to send to gouda, ${response.error}`, 'error')
					}
				} catch (error: any) {
					console.log(error)
					updateButtonState(goudaButton, buttonStates.failure);
					showPopup(`Failed to send to gouda, ${error.message}`, 'error')
				}
			};

			const dropdown = createDropDown(categories.cat);
			controlsContainer.appendChild(dropdown);
		}
	} else {
		console.error('Setup is incomplete fill out baseurl and apikey')
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

init().then(_ => {
	console.log('Extension initialized...');
}).catch(e => {
	console.error('Unable to start extension')
	console.error(e);
});
