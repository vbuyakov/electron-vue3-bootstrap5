<template>

  <div class="container px-5 py-5">
    
    <h1>💖 {{t('helloWorld')}}</h1>
    <p>{{t('welcomeTo')}} {{t('electronApplication')}}</p>
    <button class="btn btn-danger">
      <i class="bi bi-camera-video fs-5 me-2"></i>
      {{t('clickMe')}}</button>
  </div>
  <footer class="bg-dark text-white py-4">
    <div class="container">
      <p>
        <span v-for="(locale, i) in $i18n.availableLocales" :key="`locale-${locale}`" 
        :class="{'border-end pe-2': i < $i18n.availableLocales.length - 1,
          'ps-2': i !== 0,
        }">

        
        <button 
        class="btn btn-link text-white border-radius-none"
        style="min-width: 3rem;" 
        :class="{'fw-bold text-decoration-none': locale === $i18n.locale}"
        @click="changeLanguage(locale)">{{locale}}</button>
        </span>
        </p>
    </div>
  </footer>
  </template>

<script setup>
import { useI18n } from 'vue-i18n';
import { ref } from 'vue';
const { t, i18n, locale } = useI18n({useScope: "global"});

const changeLanguage = (lang) => {
  locale.value = lang;
}
</script>