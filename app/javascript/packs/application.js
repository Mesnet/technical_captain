// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import * as bootstrap from "bootstrap";
import initializeCharacterFormSliders from "../components/character_form_slider";
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Initialize the slider only when the character form is present
document.addEventListener("turbolinks:load", () => {
  const characterForm = document.querySelector("form[action*='characters']");
  if (characterForm) {
    initializeCharacterFormSliders();
  }
});
