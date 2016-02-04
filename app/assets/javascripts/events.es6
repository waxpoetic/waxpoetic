export function toggleMapSlider(event) {
  $(event.currentTarget).toggle('slide');
};

export default function(page) {
  page.on('.event .location', exports.toggleMapSlider);
}
