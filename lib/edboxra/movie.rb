class Edboxra::Movie
  attr_accessor :id, :name, :release_date, :image,
                :genre_ids, :blu_ray, :description,
                :rating, :running_time, :actors, :genre

  def blu_ray?
    blu_ray == true
  end
end
