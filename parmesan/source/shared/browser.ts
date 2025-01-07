export const browserAPI = (() => {
	if (typeof chrome !== 'undefined') {
		return chrome;
	} else if (typeof browser !== 'undefined') {
		return browser;
	}
	throw new Error('No browser API found');
})();

// Add type declaration
declare const browser: typeof chrome;
