class ArticlesDecorator < CollectionDecorator
  delegate :cache_key

  def carousel_cache_key
    [ cache_key, 'carousel' ].join('/')
  end
end
