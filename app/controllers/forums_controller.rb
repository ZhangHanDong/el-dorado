class ForumsController < ApplicationController
  
  before_filter :redirect_to_home, :except => [:index, :show]
  
  def index
    @categories = Category.find(:all, :include => [:forums], :order => 'categories.position, forums.position')
  end

  def show
    @forum = Forum.find(params[:id], :include => :category)
    if logged_in?
      @topics = Topic.find(:all, :include => [:user, :last_poster], :order => 'last_post_at desc', :conditions => ["forum_id = ?", @forum.id])
    else
      @topics = Topic.find(:all, :include => [:user, :last_poster], :order => 'last_post_at desc', :conditions => ["forum_id = ? and private = ?", @forum.id, false])
    end
    render(:template => "topics/index")
  end
 
end
