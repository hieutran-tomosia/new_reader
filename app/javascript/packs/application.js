// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
require.context("../images", true, /\.(png|jpg|jpeg|svg|ico)$/);
require("jquery");

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import Bests from "./bests"

const bests = new Bests();
window.Bests = bests;

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import * as Routes from 'routes.js.erb';
window.Routes = Routes;
