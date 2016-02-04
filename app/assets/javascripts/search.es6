/**
 * Auto-complete search results.
 */

import debounce from 'lodash/debounce';

/**
 * Render search results within the dropdown of the search form nav
 * element.
 *
 * @param {DOMEvent} event - Ajax success DOM event.
 * @param {String} response - HTML response of the search results.
 */
export function results(event, response) {
  let input = $(event.currentTarget),
      results = input.closest('results');

  if (response !== results.html()) {
    results.html(response);
  }

  results.show();
};

/**
 * Submit the `#search form` asynchronously when more than 3 characters are
 * typed into its query field.
 *
 * @param {DOMEvent} event
 */
export function autocomplete(event) {
  let input = $(event.currentTarget),
      form = input.closest('form');

  if (input.val().length >= 3) {
    form.trigger('submit.rails');
  }
};

export default function(page) {
  page.find('#search form').on('ajax:success', results);
  page.find('#search .query').on('change', debounce(autocomplete));
}
