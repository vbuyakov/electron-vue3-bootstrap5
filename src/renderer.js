import { createApp } from 'vue';
import App from './App.vue';
import { createI18n } from 'vue-i18n';

// Dynamically import all locale files
const locales = import.meta.glob('./locales/*.json', { eager: true });
const messages = {};

// Process each locale file
Object.entries(locales).forEach(([path, module]) => {
    const locale = path.match(/\.\/locales\/(.+)\.json$/)[1];
    messages[locale] = module.default;
});

const i18n = createI18n({
    locale: 'en', // default locale
    fallbackLocale: 'en', // fallback locale
    messages,
    legacy: false, // use Composition API
    globalInjection: true // enable global injection
});

import './assets/base.scss'
import 'bootstrap'

createApp(App)
    .use(i18n)
    .mount('#app');