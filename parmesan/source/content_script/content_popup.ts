// contentScript.ts

const POPUP_NAMESPACE = 'gouda-extension';

const createStyleSheet = () => {
	const style = document.createElement('style');
	style.textContent = `
    .${POPUP_NAMESPACE}-popup {
      position: fixed;
      top: 16px;
      right: 16px;
      padding: 12px 16px;
      border-radius: 4px;
      max-width: 300px;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      font-size: 14px;
      line-height: 1.5;
      z-index: 2147483647;
      animation: ${POPUP_NAMESPACE}-slideIn 0.3s ease-out;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      display: flex;
      align-items: center;
      gap: 8px;
      box-sizing: border-box;
    }

    .${POPUP_NAMESPACE}-popup * {
      all: revert;
      box-sizing: border-box;
    }

    .${POPUP_NAMESPACE}-popup.success {
      background: #f0fdf4;
      border: 1px solid #bbf7d0;
      color: #166534;
    }

    .${POPUP_NAMESPACE}-popup.error {
      background: #fef2f2;
      border: 1px solid #fecaca;
      color: #991b1b;
    }

    .${POPUP_NAMESPACE}-popup.info {
      background: #eff6ff;
      border: 1px solid #bfdbfe;
      color: #1e40af;
    }

    .${POPUP_NAMESPACE}-close {
      background: none;
      border: none;
      color: currentColor;
      cursor: pointer;
      padding: 4px;
      margin: -4px;
      opacity: 0.7;
      margin-left: 8px;
      line-height: 1;
    }

    .${POPUP_NAMESPACE}-close:hover {
      opacity: 1;
    }

    @keyframes ${POPUP_NAMESPACE}-slideIn {
      from {
        transform: translateY(-100%);
        opacity: 0;
      }
      to {
        transform: translateY(0);
        opacity: 1;
      }
    }

    .${POPUP_NAMESPACE}-popup.fade-out {
      animation: ${POPUP_NAMESPACE}-fadeOut 0.3s ease-in forwards;
    }

    @keyframes ${POPUP_NAMESPACE}-fadeOut {
      from {
        transform: translateY(0);
        opacity: 1;
      }
      to {
        transform: translateY(-100%);
        opacity: 0;
      }
    }
  `;
	return style;
};

const initializePopup = () => {
	if (!document.querySelector(`style[data-namespace="${POPUP_NAMESPACE}"]`)) {
		const style = createStyleSheet();
		style.setAttribute('data-namespace', POPUP_NAMESPACE);
		document.head.appendChild(style);
	}
};

export const showPopup = (
	message: string,
	type: 'success' | 'error' | 'info' = 'info',
	duration = 3000
) => {
	initializePopup();

	// Remove existing popup if present
	const existingPopup = document.querySelector(`.${POPUP_NAMESPACE}-popup`);
	if (existingPopup) {
		existingPopup.remove();
	}

	// Create popup container
	const popup = document.createElement('div');
	popup.className = `${POPUP_NAMESPACE}-popup ${type}`;

	// Create message element
	const messageSpan = document.createElement('span');
	messageSpan.textContent = message;

	// Create close button
	const closeButton = document.createElement('button');
	closeButton.className = `${POPUP_NAMESPACE}-close`;
	closeButton.innerHTML = '✕';
	closeButton.onclick = () => {
		popup.classList.add('fade-out');
		setTimeout(() => popup.remove(), 300);
	};

	// Assemble popup
	popup.appendChild(messageSpan);
	popup.appendChild(closeButton);
	document.body.appendChild(popup);

	const dismiss = () => {
		popup.classList.add('fade-out');
		setTimeout(() => popup.remove(), 300);
	};

	let timeoutId: number | null = null;

	const startTimer = () => {
		if (duration) {
			timeoutId = window.setTimeout(dismiss, duration);
		}
	};

	const clearTimer = () => {
		if (timeoutId !== null) {
			clearTimeout(timeoutId);
			timeoutId = null;
		}
	};

	// Add hover listeners
	popup.addEventListener('mouseenter', clearTimer);
	popup.addEventListener('mouseleave', () => {
		dismiss();  // Dismiss immediately on mouse leave
	});

	// Start initial timer
	startTimer();

	return popup;
};
