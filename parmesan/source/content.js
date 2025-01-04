console.log('💈 Content script loaded for', chrome.runtime.getManifest().name);

const browserAPI = chrome || browser;

async function sendInfo(apikey, url) {
	console.log('Sending ');
	const author = getAuthorText() ?? "default"
	const bookName = getTitleText() ?? "default"
	const link = getDownloadLink() ?? ""
	const book_url = parseInt((window.location.href).split('/').pop());
	const cat = document.getElementById('gouda_cat').value;

	console.log(`Category: ${cat} - Author: ${author} - Book: ${bookName}`);

	const body = JSON.stringify({
		file_link: link,
		author: author,
		book: bookName,
		category: cat,
		mam_book_id: book_url
	})

	const options = {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			Authorization: apikey
		},
		body: body
	};

	const resp = await fetch(`${url}/api/torrent/addTorrent`, options)
	if (resp.status > 399) {
		throw new Error(`Failed to call api. Status:${resp.statusText}, message: ${JSON.stringify(await resp.json())}`);
	}
}

function getAuthorText() {
	const authorElement = document.querySelector('.torDetRight.torAuthors a');
	if (authorElement) {
		return authorElement.textContent.trim();
	}
	console.log('Author element not found');
	return null;
}

function getTitleText() {
	const titleElement = document.querySelector('.torDetRight .TorrentTitle');
	if (titleElement) {
		return titleElement.textContent.trim();
	}
	console.log('Title element not found');
	return null;
}

function getDownloadLink() {
	const downloadElement = document.querySelector('#tddl');
	if (downloadElement) {
		return downloadElement.href;
	}
	console.log('Download link not found');
	return null;
}

function updateButtonState(button, state, duration = 1000) {
	// Store the previous state
	const previousState = {
		text: button.textContent,
		backgroundColor: button.style.backgroundColor,
		color: button.style.color
	};

	// Update to new state
	button.textContent = state.text;
	button.style.backgroundColor = state.backgroundColor;
	button.style.color = state.color;

	// Reset to previous state after duration
	setTimeout(() => {
		button.textContent = previousState.text;
		button.style.backgroundColor = previousState.backgroundColor;
		button.style.color = previousState.color;
	}, duration);
}

const buttonStates = {
	success: {
		text: 'Success!',
		backgroundColor: '#4CAF50',
		color: 'white'
	},
	failure: {
		text: 'Failed!',
		backgroundColor: '#f44336',
		color: 'white'
	}
};

async function createDropDown(baseUrl, apikey) {
	// Create dropdown
	const dropdown = document.createElement('select');
	dropdown.id = 'gouda_cat'
	dropdown.style.padding = '8px';
	dropdown.style.borderRadius = '4px';

	const options = {
		method: 'GET',
		headers: {
			'Content-Type': 'application/json',
			Authorization: apikey
		},
	};
	const resp = await fetch(`${baseUrl}/api/category/list`, options)
	if (resp.status > 400) {
		throw new Error(`Failed to call api. Status:${resp.statusText}, message: ${resp.statusText}`);
	}

	const cat = await resp.json()

	const defaultOption = document.createElement('option');
	defaultOption.value = '';
	defaultOption.textContent = 'Select option';
	dropdown.appendChild(defaultOption);

	if (resp.status > 400) {
		console.error('Error loading options:', resp.statusText);
		// Add error option
		const errorOption = document.createElement('option');
		errorOption.textContent = 'Error loading options';
		dropdown.appendChild(errorOption);
		return dropdown;
	}

	// Add options from API response
	cat.forEach(item => {
		const option = document.createElement('option');
		option.value = item.category;
		option.textContent = item.category;
		dropdown.appendChild(option);
	});

	if (cat[0]) {
		dropdown.value = cat[0].category;
	}

	return dropdown;
}

async function init() {
	const settings = await browserAPI.storage.sync.get(['gouda_baseurl', 'gouda_apikey']);

	const downloadDiv = document.createElement('div');
	downloadDiv.id = 'download';
	downloadDiv.className = 'torDetInnerCon';

	const innerTop = document.createElement('div');
	innerTop.className = 'torDetInnerTop';

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
				await sendInfo(settings.gouda_apikey, settings.gouda_baseurl);
				updateButtonState(goudaButton, buttonStates.success);
			} catch (error) {
				console.log(error)
				alert(`Failed to send to gouda, check your apikey and url in settings: ${error}`)
				updateButtonState(goudaButton, buttonStates.failure);
			}
		};

		const dropdown = await createDropDown(settings.gouda_baseurl, settings.gouda_apikey);
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
	const uploaderDiv = document.getElementById('uploader');
	if (uploaderDiv) {
		uploaderDiv.parentNode.insertBefore(downloadDiv, uploaderDiv.nextSibling);
	} else {
		console.log('Unable to find torrent details box');
	}
}

init().then(r => {
	console.log('Extension initialized...');
}).catch(e => {
	console.error('Unable to start extension')
	console.error(e);
});
