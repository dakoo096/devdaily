<template>
  <ion-page>
    <ion-tabs>
      <ion-router-outlet></ion-router-outlet>
      <ion-tab-bar slot="bottom">
        <ion-tab-button tab="home" href="/app/home" id="tab-home">
          <ion-icon :icon="todayOutline" />
          <ion-label>Hoy</ion-label>
        </ion-tab-button>

        <ion-tab-button tab="favorites" href="/app/favorites" id="tab-favorites">
          <ion-icon :icon="heartOutline" />
          <ion-label>Favoritos</ion-label>
        </ion-tab-button>

        <ion-tab-button tab="history" href="/app/history" id="tab-history">
          <ion-icon :icon="timeOutline" />
          <ion-label>Historial</ion-label>
        </ion-tab-button>

        <ion-tab-button tab="profile" href="/app/profile" id="tab-profile">
          <ion-icon :icon="personOutline" />
          <ion-label>Perfil</ion-label>
        </ion-tab-button>
      </ion-tab-bar>
    </ion-tabs>
  </ion-page>
</template>

<script setup lang="ts">
import {
  IonPage,
  IonTabs,
  IonRouterOutlet,
  IonTabBar,
  IonTabButton,
  IonIcon,
  IonLabel,
} from '@ionic/vue';
import { todayOutline, heartOutline, timeOutline, personOutline } from 'ionicons/icons';
</script>
