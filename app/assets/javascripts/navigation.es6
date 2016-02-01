let toggleActiveClass = function(event) {
  $('#links li').removeClass('active');
  $(event.currentTarget).closest('li').addClass('active');
};

export default function(page) {
  page.find('header nav a').on('click', toggleActiveClass);
}
