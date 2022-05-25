class WidgetsController < ApplicationController
  DUMMY_STATIC_VALUE = "dummystaticvalue"
  DUMMY_STATIC_TIMESTAMP = Time.new(2022,5,23,0,0,0).utc

  def show
    @widget = get_widget
    if even? && request.headers["HTTP_IF_NONE_MATCH"]
      head :not_modified
    else
      render :show
    end
  end

  private

  def get_widget
    if even?
      { etag: DUMMY_STATIC_VALUE,
        last_modified: DUMMY_STATIC_TIMESTAMP,
        public: true }
    else
      { etag: random_string,
        last_modified: Time.now,
        public: true }
    end
  end

  def even?
    params[:id].to_i % 2 == 0 # Just check if :id is odd/even
  end

  def random_string
    (0...15).map { ('a'..'z').to_a[rand(26)] }.join
  end
end
