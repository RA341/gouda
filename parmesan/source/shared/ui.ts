export {
	updateButtonState,
	ButtonState,
	ButtonStateTypes,
	buttonStates,
}

function updateButtonState(
	button: HTMLAnchorElement,
	state: ButtonState,
	duration: number = 1000
): void {
	// Store the previous state
	const previousState: ButtonState = {
		text: button.textContent || '',
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

interface ButtonState {
	text: string;
	backgroundColor: string;
	color: string;
}

type ButtonStateTypes = 'success' | 'failure' | 'loading';

const buttonStates: Record<ButtonStateTypes, ButtonState> = {
	success: {
		text: 'Success!',
		backgroundColor: '#4CAF50',
		color: 'white'
	},
	failure: {
		text: 'Failed!',
		backgroundColor: '#f44336',
		color: 'white'
	},
	loading: {
		text: 'sending...',
		backgroundColor: '#697cf6',
		color: 'white'
	},
};
