/* Copyright 2018 Christon DeWan (xton)
 * Copyright 2017 IslandMan93
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#pragma once

// place overrides here
//#define PERMISSIVE_HOLD
#define MASTER_LEFT
#define TAPPING_TERM 175
#define IGNORE_MOD_TAP_INTERRUPT
#define TAPPING_FORCE_HOLD

// home row mod keys
#define HRM_A LGUI_T(KC_A)
#define HRM_R LALT_T(KC_R)
#define HRM_S LCTL_T(KC_S)
#define HRM_T RSFT_T(KC_T)

#define HRM_N RSFT_T(KC_N)
#define HRM_E RCTL_T(KC_E)
#define HRM_I RALT_T(KC_I)
#define HRM_O RGUI_T(KC_O)

// Layer switching keys
#define L1_Z LT(1, KC_Z)
#define L3_SLSH LT(3,KC_SLSH)
#define L4_DOT LT(4,KC_DOT)
#define L5_COMM LT(5,KC_COMM)
