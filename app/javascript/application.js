import "@hotwired/turbo-rails";
import { Turbo } from "@hotwired/turbo-rails";
Turbo.start();

import { Application } from "@hotwired/stimulus";
import { definitionsFromContext } from "@hotwired/stimulus-loading";

const application = Application.start();
const context = require.context("controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

import "stylesheets/application";

// You can add additional JavaScript or Stimulus controllers here as needed
