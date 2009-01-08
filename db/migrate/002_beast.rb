class Beast < ActiveRecord::Migration
	
	
	def self.up
    
    add_column :forums, :description_html, :text
    add_column :forums, :topics_count, :integer,     :default => 0
    add_column :forums, :posts_count, :integer,      :default => 0
	
	  create_table "moderatorships", :force => true do |t|
	    t.integer "forum_id"
	    t.integer "user_id"
	  end
	
	  add_index "moderatorships", ["forum_id"], :name => "index_moderatorships_on_forum_id"
	
	  create_table "monitorships", :force => true do |t|
	    t.integer "topic_id"
	    t.integer "user_id"
	    t.boolean "active",   :default => true
	  end
	
	  create_table "posts", :force => true do |t|
	    t.integer  "user_id"
	    t.integer  "topic_id"
	    t.text     "body"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	    t.integer  "forum_id"
	    t.text     "body_html"
	  end
	
	  add_index "posts", ["forum_id", "created_at"], :name => "index_posts_on_forum_id"
	  add_index "posts", ["user_id", "created_at"], :name => "index_posts_on_user_id"
	  add_index "posts", ["topic_id", "created_at"], :name => "index_posts_on_topic_id"
	
	  create_table "topics", :force => true do |t|
	    t.integer  "forum_id"
	    t.integer  "user_id"
	    t.string   "title"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	    t.integer  "hits",         :default => 0
	    t.integer  "sticky",       :default => 0
	    t.integer  "posts_count",  :default => 0
	    t.datetime "replied_at"
	    t.boolean  "locked",       :default => false
	    t.integer  "replied_by"
	    t.integer  "last_post_id"
	  end
	
	  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"
	  add_index "topics", ["forum_id", "sticky", "replied_at"], :name => "index_topics_on_sticky_and_replied_at"
	  add_index "topics", ["forum_id", "replied_at"], :name => "index_topics_on_forum_id_and_replied_at"	
	  
		add_column :users, :posts_count, :integer, :default => 0
    add_column :users, :last_seen_at, :datetime
  end

  def self.down
		remove_column :users, :posts_count
		remove_column :users, :last_seen_at
		
		remove_column :forums, :description_html
    remove_column :forums, :topics_count
    remove_column :forums, :posts_count
    
    drop_table :topics
    drop_table :posts
    drop_table :monitorships
    drop_table :moderatorships
    drop_table :forums    
  end
  
end
