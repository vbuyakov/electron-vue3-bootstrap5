# Vue2Kiosk Base

A modern Vue.js-based kiosk application template with Electron integration, internationalization support, and Bootstrap styling.

## Features

- 🚀 Vue 3 with Composition API
- 🌐 Dynamic i18n support (automatically loads all locale files)
- 💅 Bootstrap integration
- 📦 Electron for desktop application
- 🔄 Hot Module Replacement (HMR)
- 🎨 SCSS support

## Prerequisites

- Node.js (v14 or higher)
- npm or yarn

## Installation

1. Clone the repository and enter project directory
``` bash
nvm use
```

2. Install dependencies:
```bash
npm install
# or - originaly used NPM
yarn install
```

## Development

Start the development server:
```bash
npm run start
# or
yarn start
```

## Building

Build the application for production for current platform:
```bash
npm run make
# or
yarn make
```

Build the application for ARM64 Linux
(It's good to run on Windows w/o WSL)
```bash
npm run docker-build
```
## Adding New Languages

1. Create a new JSON file in `src/locales/` directory (e.g., `de.json`)
2. Add your translations following the existing format:
```json
{
    "helloWorld": "Hallo Welt",
    "clickMe": "Klick mich",
    "welcomeTo": "Willkommen bei",
    "electronApplication": "Electron Anwendung"
}
```
The new language will be automatically detected and added to the application.

## Project Structure

```
src/
├── locales/           # Translation files
│   ├── en.json
│   ├── fr.json
│   └── es.json
├── assets/           # Static assets
│   └── base.scss
├── App.vue          # Root component
└── renderer.js      # Main entry point
```

## Available Scripts

- `npm run start` - Start development server
- `npm run make` - Build for production
- `npm run lint` - Run ESLint
- `npm run docker-build` - Build in docker for Arm64 Linux
## Technologies Used

- Vue 3
- Vue I18n
- Electron
- Bootstrap
- SCSS
- Vite

