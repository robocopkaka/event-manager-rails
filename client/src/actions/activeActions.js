import { CENTERS_ACTIVE, EVENTS_ACTIVE, HOME_ACTIVE } from './actionTypes';

export function centersActive() {
  return { type: CENTERS_ACTIVE };
}

export function eventsActive() {
  return { type: EVENTS_ACTIVE };
}

export function homeActive() {
  return { type: HOME_ACTIVE };
}