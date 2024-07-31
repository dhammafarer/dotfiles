// Copyright 2023 QMK
// SPDX-License-Identifier: GPL-2.0-or-later

#include QMK_KEYBOARD_H

enum layer_names {
  COLEMAK,
  NAV,     // Navigation
  NUM,     // Numbers
  MOU,     // Mouse layer
  SYM,     // Alternative access to symbols
  PCT,     // Punctuation
  FUN,     // Function keys
  LHN,     // Left hand only NAV
  HSH,     // special characters
  RHN,     // Right hand only NAV
  MED,     // media keys
  APP,     // App Lauch keys
};

// mode tap keys
// LEFT
#define HM_A LALT_T(KC_A)
#define HM_Q LALT_T(KC_Q)
#define HM_R LSFT_T(KC_R)
#define HM_S LCTL_T(KC_S)
#define HM_T LGUI_T(KC_T)

#define HM_L LT(APP,KC_L)
#define HM_U LT(SYM,KC_U)
#define HM_Z LT(LHN,KC_Z)
#define HM_D LT(MED,KC_D)
#define HM_F LT(PCT,KC_F)

// Right
#define HM_N RGUI_T(KC_N)
#define HM_E RCTL_T(KC_E)
#define HM_I RSFT_T(KC_I)
#define HM_O RALT_T(KC_O)

#define HM_H LT(SYM,KC_H)
#define HM_SLSH LT(RHN,KC_SLSH)

// Thumbs layers:
// Left Thumb
#define TK_LI LT(PCT, KC_ESC)
#define TK_LC LT(NAV, KC_SPC)
#define TK_LO LT(MOU, KC_TAB)

// Right Thumb
#define TK_RO LT(SYM, KC_ENT)
#define TK_RC LT(NUM, KC_BSPC)
#define TK_RI LT(FUN, KC_DEL)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

[COLEMAK] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
     XXXXXXX,  KC_Q,    KC_W,    HM_F,    KC_P,    KC_B,                         KC_J,    HM_L,    HM_U,    KC_Y,   KC_QUOT, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  HM_A,    HM_R,    HM_S,    HM_T,    KC_G,                         KC_M,    HM_N,    HM_E,    HM_I,    HM_O,   XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  HM_Z,    KC_X,    KC_C,    HM_D,    KC_V,                         KC_K,    HM_H,   KC_COMM, KC_DOT,  HM_SLSH, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          TK_LI,   TK_LC,   TK_LO,      TK_RO,   TK_RC,   TK_RI
                                      //`--------------------------'  `--------------------------'
),

[NAV] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                       KC_MENU,  KC_GRV, KC_QUOT, KC_DQUO, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX, KC_LALT, KC_LSFT, KC_LCTL, KC_LGUI, XXXXXXX,                       KC_APP, KC_LEFT, KC_DOWN,  KC_UP,  KC_RIGHT, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                       KC_INS, KC_HOME, KC_PGDN, KC_PGUP, KC_END,   XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          _______, _______, _______,    _______, _______, _______
                                      //`--------------------------'  `--------------------------'
),

[NUM] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
     XXXXXXX,  KC_LBRC,  KC_7,   KC_8,    KC_9,    KC_AT,                       XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  KC_COLN,  KC_1,   KC_2,    KC_3,    KC_PLUS,                      XXXXXXX, KC_RGUI, KC_RCTL, KC_RSFT, KC_RALT, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  KC_DOT,   KC_4,   KC_5,    KC_6,    KC_EQL,                       XXXXXXX,  HM_H,   KC_COMM, KC_DOT,  HM_SLSH, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          KC_DOT,  KC_0,   KC_MINS,     _______, _______, _______
                                      //`--------------------------'  `--------------------------'
),

[MOU] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX, KC_LALT, KC_LSFT, KC_LCTL, KC_LGUI, XXXXXXX,                       XXXXXXX, KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                       XXXXXXX, KC_VOLD, KC_WH_D, KC_WH_U, KC_VOLU, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          _______, _______, _______,    KC_BTN1, KC_BTN3, KC_BTN2
                                      //`--------------------------'  `--------------------------'
),
 
[SYM] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
     XXXXXXX, XXXXXXX,  KC_AMPR, KC_AT,   KC_PIPE, KC_ASTR,                      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  KC_COLN, KC_EXLM, KC_PERC, KC_EQL,  KC_PLUS,                      XXXXXXX, KC_RGUI, KC_RCTL, KC_RSFT, KC_RALT, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  KC_TILD, KC_HASH, KC_BSLS, KC_SCLN, KC_EQL,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          KC_CAPS, KC_UNDS, KC_MINS,    _______, _______, _______
                                      //`--------------------------'  `--------------------------'
),

[PCT] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                       XXXXXXX, XXXXXXX, KC_LBRC, KC_RBRC, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX, KC_LALT, KC_LSFT, KC_LCTL, KC_LGUI, XXXXXXX,                       XXXXXXX, KC_LPRN, KC_LCBR, KC_RCBR, KC_RPRN, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                       XXXXXXX, KC_HASH, KC_CIRC, KC_DLR,  KC_BSLS, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          KC_MUTE, KC_MPLY, KC_F20,    _______, _______, _______
                                      //`--------------------------'  `--------------------------'
),

[FUN] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
     XXXXXXX,  KC_F10,  KC_F7,   KC_F8,   KC_F9,  XXXXXXX,                      XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  KC_F11,  KC_F1,   KC_F2,   KC_F3,  XXXXXXX,                      XXXXXXX, KC_RGUI, KC_RCTL, KC_RSFT, KC_RALT, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  KC_F12,  KC_F4,   KC_F5,   KC_F6,  XXXXXXX,                      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          _______, _______, _______,    _______, _______, _______
                                      //`--------------------------'  `--------------------------'
),

[LHN] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
     XXXXXXX,  XXXXXXX, KC_HOME, KC_UP,   KC_END,  XXXXXXX,                     XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  XXXXXXX, KC_LEFT, KC_DOWN, KC_RGHT, XXXXXXX,                     XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                     XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          KC_DEL, KC_BSPC,  KC_ENT,     _______, _______, _______
                                      //`--------------------------'  `--------------------------'
),

[HSH] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
     XXXXXXX,  KC_QUOT, KC_RABK, KC_CIRC, KC_PLUS, KC_RCBR,                      S(KC_H), KC_4,    KC_AT,   S(KC_Q), XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  KC_GRV,  KC_PERC, KC_DQT,  KC_TILD, KC_COMM,                      KC_BSLS, KC_SCLN, KC_UNDS, KC_HASH, S(KC_J), XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  KC_ASTR, KC_QUES, KC_8,    KC_LCBR, KC_SLSH,                      KC_EQL,  KC_7,    KC_LBRC, KC_LPRN, KC_COLN, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          XXXXXXX, KC_AMPR, XXXXXXX,    XXXXXXX, XXXXXXX, XXXXXXX
                                      //`--------------------------'  `--------------------------'
),

[RHN] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
     XXXXXXX,  KC_HOME, KC_UP,   KC_END,  KC_PGUP, XXXXXXX,                     XXXXXXX, KC_HOME,  KC_UP,   KC_END,  XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                     XXXXXXX, KC_LEFT,  KC_DOWN, KC_RGHT, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                     XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                         XXXXXXX, XXXXXXX, XXXXXXX,     KC_TAB, KC_SPC,  KC_ESC
                                      //`--------------------------'  `--------------------------'
),

[MED] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
     XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                     XXXXXXX, KC_MPRV, KC_VOLD, KC_VOLU, KC_MNXT, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                         XXXXXXX, XXXXXXX, XXXXXXX,     KC_F20, KC_MPLY, KC_MUTE
                                      //`--------------------------'  `--------------------------'
),

[APP] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
     XXXXXXX, KC_WBAK, KC_BRID, KC_BRIU, KC_WFWD, XXXXXXX,                      QK_BOOT, XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX, KC_MSEL, KC_CALC, KC_WHOM, KC_WSCH, KC_MYCM,                      XXXXXXX, KC_RGUI, KC_RCTL, KC_RSFT, KC_RALT, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          _______, _______, _______,    _______, _______, _______
                                      //`--------------------------'  `--------------------------'
)
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {

    // Prevent accidental activation of Layer 6
    case HM_N:
        if (record->event.pressed && record->tap.count > 0) {
            if (get_mods() & MOD_BIT(KC_RSFT)) {
                unregister_mods(MOD_BIT(KC_RSFT));
                tap_code(KC_N);
                add_mods(MOD_BIT(KC_RSFT));
                return false;
            }
            if (get_mods() & MOD_BIT(KC_RCTL)) {
                unregister_mods(MOD_BIT(KC_RCTL));
                tap_code(KC_E);
                tap_code(KC_N);
                add_mods(MOD_BIT(KC_RCTL));
                return false;
            }
        }
        return true;

    // Prevent accidenal activation of Left Control
    case HM_T:
        if (record->event.pressed && record->tap.count > 0) {
            if (get_mods() & MOD_BIT(KC_LCTL)) {
                unregister_mods(MOD_BIT(KC_LCTL));
                tap_code(KC_S);
                tap_code(KC_T);
                add_mods(MOD_BIT(KC_LCTL));
                return false;
            }
        }
        return true;

    case HM_S:
        if (record->event.pressed && record->tap.count > 0) {
            if (get_mods() & MOD_BIT(KC_LALT)) {
                unregister_mods(MOD_BIT(KC_LALT));
                tap_code(KC_R);
                tap_code(KC_S);
                add_mods(MOD_BIT(KC_LALT));
                return false;
            }
        }
        return true;

    // Prevent activation of Layer 2 on outward roll
    case HM_E:
        //if (record->event.pressed && record->tap.count > 0) {
        if (record->event.pressed && record->tap.count > 0) {
            if (get_mods() & MOD_BIT(KC_RSFT)) {
                unregister_mods(MOD_BIT(KC_RSFT));
                tap_code(KC_I);
                tap_code(KC_E);
                add_mods(MOD_BIT(KC_RSFT));
                return false;
            }
        }
        return true;

    // Prevent activaction of Layer 3 on outward roll
    case HM_A:
        if (record->event.pressed) {
            if (IS_LAYER_ON(5)) {
                layer_off(5);
                tap_code(KC_R);
                tap_code(KC_A);
                return false;
            }
        }
        return true;

    // Prevent activaction of Layer 4 on outward roll
    case HM_O:
        if (record->event.pressed && record->tap.count > 0) {
            if (get_mods() & MOD_BIT(KC_RSFT)) {
                unregister_mods(MOD_BIT(KC_RSFT));
                tap_code(KC_I);
                tap_code(KC_O);
                add_mods(MOD_BIT(KC_RSFT));
                return false;
            }
        }
        return true;

    case HM_I:
        if (record->event.pressed && record->tap.count > 0) {
            if (get_mods() & MOD_BIT(KC_RGUI)) {
                unregister_mods(MOD_BIT(KC_RGUI));
                tap_code(KC_N);
                tap_code(KC_I);
                add_mods(MOD_BIT(KC_RGUI));
                return false;
            }
            if (get_mods() & MOD_BIT(KC_RALT)) {
                unregister_mods(MOD_BIT(KC_RALT));
                tap_code(KC_O);
                tap_code(KC_I);
                add_mods(MOD_BIT(KC_RALT));
                return false;
            }
        }
        return true;

    }
    return true;
};
