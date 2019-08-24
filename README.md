This project contains a simple ruby benchmark script to compare performance of `as_json_representation` gem with other serialization gems.

#### Install && Run

`bundle install`

`ruby benchmarks.rb`

#### Output

```
---- fast_jsonapi ----

{:data=>
  {:id=>"3",
   :type=>:movie,
   :attributes=>{:name=>"test movie", :year=>1990},
   :relationships=>
    {:actors=>
      {:data=>
        [{:id=>"1", :type=>:actor},
         {:id=>"2", :type=>:actor},
         {:id=>"3", :type=>:actor}]},
     :owner=>{:data=>{:id=>"3", :type=>:user}},
     :movie_type=>{:data=>{:id=>"1", :type=>:movie_type}}}}}

---- blueprinter ----

{:id=>232,
 :actor_ids=>[1, 2, 3],
 :movie_type_id=>1,
 :name=>"test movie",
 :owner_id=>3,
 :year=>1990}

---- as_json_representations ----

{:id=>232,
 :name=>"test movie",
 :year=>1990,
 :actor_ids=>[1, 2, 3],
 :owner_id=>3,
 :movie_type_id=>1}

---- 10000 iterations times ----

                                user     system      total        real
fast_jsonapi                0.083307   0.000056   0.083363 (  0.085233)
blueprinter                 0.088615   0.000000   0.088615 (  0.089131)
as_json_representations     0.011665   0.000000   0.011665 (  0.011665)
```
