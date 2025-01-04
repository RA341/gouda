const browserAPI = chrome || browser;

console.log('loading pop js')

document.addEventListener('DOMContentLoaded', async () => {
	console.log('Document loaded')

	const settings = await browserAPI.storage.sync.get(['gouda_baseurl', 'gouda_apikey']);

	console.log('loaded settings');
	console.log(settings.gouda_baseurl);

	// Set input values
	document.getElementById('baseUrl').value = settings.gouda_baseurl || '';
	document.getElementById('apikey').value = settings.gouda_apikey || '';

	// Save settings when button is clicked
	document.getElementById('save').addEventListener('mousedown', async () => {
		console.log('clicking save')

		const baseUrl = document.getElementById('baseUrl').value;
		const apikey = document.getElementById('apikey').value;

		console.debug(`Checking url ${baseUrl} with apikey ${apikey}`);

		try {
			const resp = await fetch(`${baseUrl}/auth/test`, {
				method: 'GET', headers: {
					Authorization: apikey
				}
			})

			if (!resp.ok) throw Error(`Invalid token: ${resp.status}`);

			await browserAPI.storage.sync.set({
				'gouda_baseurl': baseUrl, 'gouda_apikey': apikey
			});

			// Optional: Show save confirmation
			alert('Settings saved!');
		} catch (e) {
			console.log(e)
			alert(e)
		}
	});
});
