require 'fast_jsonapi'
require 'blueprinter'
require 'as_json_representations'
require 'benchmark'

class MovieSerializer
  include FastJsonapi::ObjectSerializer

  set_type :movie  # optional
  set_id :owner_id # optional
  attributes :name, :year
  has_many :actors
  belongs_to :owner, record_type: :user
  belongs_to :movie_type
end

class MovieBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :year, :actor_ids, :owner_id, :movie_type_id
end

module MovieRepresentations
  include AsJsonRepresentations

  representation :public do |options|
    {
      id: id,
      name: name,
      year: year,
      actor_ids: actor_ids,
      owner_id: owner_id,
      movie_type_id: movie_type_id
    }
  end
end

class Movie
  include MovieRepresentations

  attr_accessor :id, :name, :year, :actor_ids, :owner_id, :movie_type_id
end

movie = Movie.new
movie.id = 232
movie.name = 'test movie'
movie.actor_ids = [1, 2, 3]
movie.owner_id = 3
movie.movie_type_id = 1
movie.year = 1990
movie

puts MovieSerializer.new(movie).serializable_hash
puts MovieBlueprint.render_as_hash(movie)
puts movie.as_json(representation: :public)

puts (Benchmark.measure do
  10000.times { MovieSerializer.new(movie).serializable_hash }
end)

puts (Benchmark.measure do
  10000.times { MovieBlueprint.render_as_hash(movie) }
end)

puts (Benchmark.measure do
  10000.times { movie.as_json(representation: :public) }
end)
