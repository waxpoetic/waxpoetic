# API for accessing artist information that has been stored both in the
# local database as well as on Facebook.
#
# @api Artists
class ArtistsController < ApplicationController
  resource :artist

  # Return all artists.
  #
  # @http [GET] /artists.json
  # @example format="json"
  #   {
  #     "artists": [
  #       {
  #         "id": 1,
  #         "name": "The Wonder Bars",
  #         "bio": "<p><strong>this is the bio</strong></p>",
  #         "image": "http://files.waxpoeticrecords.com/artists/1/images/:id/full.jpg"
  #       }
  #     ]
  #   }
  def index
    respond_with artists
  end

  # Return information for a single artist.
  #
  # @http [GET] /artists/the-wonder-bars.json
  # @example
  #   {
  #     "artist": {
  #       "id": 1,
  #       "name": "The Wonder Bars",
  #       "bio": "<p><strong>this is the bio</strong></p>",
  #       "image": "http://files.waxpoeticrecords.com/artists/1/images/:id/full.jpg",
  #       "events": [
  #         {
  #           "name": "PEX Summer Festival 2016",
  #           "location": { ... },
  #           "date": "Saturday, July 4th, 2016 at 9:00PM",
  #           "ticketURL": "...",
  #           "url": "..."
  #         }
  #       ]
  #     }
  #   }
  def show
    respond_with artist
  end
end
