cd /Users/towelwet/Documents/\[Towel\ Ware\ Dev\]/Towel\ Popup\ Blocker

./build.sh

## ![img](https://raw.githubusercontent.com/schomery/popup-blocker/fe2d5bc0a03a69411520ce79c79f57c8195be077/v3/data/icons/32.png) Popup Blocker (strict)

The "Popup Blocker (strict)" is a lightweight browser extension designed to prevent the opening of popup windows on websites. Unlike other popup blockers, this extension doesn't wait to block popups after they appear; instead, it intercepts and blocks them as soon as they are requested. This extension puts a halt to all requests for new windows, requiring your input to either permit or deny each request. Multiple distinct requests are presented in a list, and if a website makes repeated requests to a specific URL, a badge number will display, indicating the total number of requests for that particular web address.

### Preview

[![Preview](https://img.youtube.com/vi/Jp-RaiTHzCQ/0.jpg)](https://www.youtube.com/watch?v=Jp-RaiTHzCQ)

### Features

* Popup blockage triggered by the window.open method
* Popup prevention through the about:blank linking technique
* Previewing popup links via a notification box

### Actions

1. Deny popup request
2. Allow popup request
3. Open popup request in a background tab
4. Redirect current page to popup URL source

### Supported blocking methods:
1. `window.open`
2. `a->target=_blank`
3. Form submission

### Links

 * FAQs Page: https://webextension.org/listing/popup-blocker.html
 * Test Page:  https://webbrowsertools.com/popup-blocker/

### Screenshot

![img](https://addons.mozilla.org/user-media/previews/full/179/179585.png)

### Make a Donation

If this project help you, you can give the developer a cup of coffee :)

* PayPal

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=inbasic%2ecorp%40gmail%2ecom&lc=CA&item_name=support%20extension%20development&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHosted)

* Bitcoin Address:

bc1qh7juzrxrawpr65elm4qs285m5rdhnhgsn7h2jf

### Help with Translation

You can now translate Popup Blocker (strict) into your language; https://www.transifex.com/github-7/popup-blocker-strict/

### License

Popup Blocker (strict) is an open-source project released under [MPL-2.0](https://github.com/schomery/popup-blocker/blob/master/LICENSE)

## Developer Documentation

### Directory Structure
```
popup-blocker/
├── build/              # Temporary build directory
├── v2/                # Manifest V2 version (legacy)
│   ├── common/        # Shared utilities
│   ├── data/         # Assets and UI files
│   └── locale/       # Internationalization files
├── v3/                # Manifest V3 version (current)
│   ├── data/         # Assets, icons and UI components
│   ├── locale/       # Translation files
│   └── worker.js     # Service worker (background script)
└── build.sh          # Build script for packaging
```

### Building the Extension

#### Prerequisites
- Unix-like environment (macOS, Linux) or WSL on Windows
- zip utility installed:
  - macOS: `brew install zip`
  - Linux: `sudo apt-get install zip`
  - WSL: `sudo apt install zip`

#### Build Steps
1. Make the build script executable:
   ```bash
   chmod +x build.sh
   ```

2. Run the build script:
   ```bash
   ./build.sh
   ```

The script will:
- Create a clean build environment
- Package the v3 version of the extension
- Generate `popup-blocker-v3.zip` in the project root

#### Build Output
- The final package will be named `popup-blocker-v3.zip`
- This ZIP can be:
  - Loaded directly into Chrome/Edge as an unpacked extension
  - Submitted to browser extension stores
  - Distributed to users for manual installation

### Development Notes

#### Version Support
- The v3/ directory contains the current Manifest V3 version
- The v2/ directory is maintained for reference only and is no longer actively built
- New development should focus on v3/
- Note: The build scripts only package v3 version as v2 is deprecated and no longer maintained

#### Testing
1. Load the extension in Chrome:
   - Go to `chrome://extensions`
   - Enable "Developer mode"
   - Click "Load unpacked"
   - Select the `v3` directory

2. Load the extension in Firefox:
   - Go to `about:debugging`
   - Click "This Firefox"
   - Click "Load Temporary Add-on"
   - Select any file from the `v3` directory

#### Contributing
1. Fork the repository
2. Create a feature branch
3. Make your changes in the v3/ directory
4. Test thoroughly
5. Submit a pull request

#### Extension Packaging Details
- The build script excludes development files like .git and node_modules
- Only necessary runtime files are included in the final package
- Manifest V3 is the primary target for new builds
