class ActionController::Base
  def almanac_request(*tags)
    @almanac = AlmanacEntry.new
    @almanac.title = "#{params[:controller]}##{params[:action]}"
    @almanac.data = params.except(:controller, :action)
    @almanac_tags = []

    yield if block_given?

    if @almanac
      @almanac.save!
      
      @almanac.tag(current_user) if respond_to? :current_user
      @almanac_tags.each {|tag| @almanac.tag(tag)}
    end
  end
end