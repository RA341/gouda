import {browserAPI} from "../shared/browser";
import {createAuthClient, createGRPCTransport} from "../shared/grpc_client";
import {AuthResponse} from "../gen/auth/v1/auth_pb";

document.addEventListener('DOMContentLoaded', async () => {
	console.log('Document loaded');

	const settings = await browserAPI.storage.sync.get(['gouda_baseurl', 'gouda_apikey']);

	console.log('loaded settings');
	console.log(settings);
	console.log(settings.gouda_apikey);
	console.log(settings.gouda_baseurl);

	// Set input values
	const baseUrlInput = document.getElementById('baseUrl') as HTMLInputElement;
	const apiKeyInput = document.getElementById('apikey') as HTMLInputElement;
	const saveButton = document.getElementById('save') as HTMLButtonElement;

	baseUrlInput.value = settings.gouda_baseurl ?? '';
	apiKeyInput.value = settings.gouda_apikey ?? '';

	// Save settings when button is clicked
	saveButton.addEventListener('mousedown', async () => {
		console.log('clicking save');

		const baseUrl = baseUrlInput.value;
		const apikey = apiKeyInput.value;

		console.debug(`Checking url ${baseUrl} with apikey ${apikey}`);

		try {
			const transport = createGRPCTransport(baseUrl, apikey)
			const authClient = createAuthClient(transport)

			await authClient.test(<AuthResponse>{
				authToken: apikey,
			})

			await browserAPI.storage.sync.set({
				'gouda_baseurl': baseUrl,
				'gouda_apikey': apikey
			});

			showStatus('Settings saved!')
		} catch (error) {
			console.log(error);
			showStatus(String(error))
		}
	});
});

function showStatus(message: string, type = 'success', duration = 3000) {
	// Remove any existing popups
	const existingPopup = document.querySelector('.status-popup');
	if (existingPopup) {
		existingPopup.remove();
	}

	// Create popup elements
	const popup = document.createElement('div');
	popup.className = `status-popup ${type}`;

	const messageSpan = document.createElement('span');
	messageSpan.textContent = message;

	const closeButton = document.createElement('button');
	closeButton.className = 'close-button';
	closeButton.innerHTML = '✕';
	closeButton.onclick = () => {
		popup.classList.add('fade-out');
		setTimeout(() => popup.remove(), 300);
	};

	// Assemble popup
	popup.appendChild(messageSpan);
	popup.appendChild(closeButton);
	document.body.appendChild(popup);

	// Auto-remove after duration
	if (duration) {
		setTimeout(() => {
			if (popup.parentElement) {
				popup.classList.add('fade-out');
				setTimeout(() => popup.remove(), 300);
			}
		}, duration);
	}

	return popup;
}
