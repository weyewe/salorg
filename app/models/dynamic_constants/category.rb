class Category < ActiveRecord::Base
  # attr_accessible :title, :body
  # we use some of the graphy theory : node and edge 
  # the Category is the node. The link up between one category and its sub category is called
  # the category edge 
  
  # category edge stores
    # 1. the parent category 
    # 2. the child category
    # 3. the distance (tree level). direct access. no traversal is needed 
    
  # the category node stores
    # 1. the category title
    # 2. the absolute level ( starts from 0)
    
  has_many :category_edges
  has_many :sub_categories, :through => :category_edges,
              :source => :sub_category 
              
  after_create :propagate_edge_creation_to_the_root
  before_destroy :propagate_edge_deletion_to_the_root
  
  attr_accessible :title, :description 
              
=begin
  For the self many-many referential 
=end
  def direct_parent_category
    if self.is_root_category == true
       return self
    elsif self.is_root_category == false
      return Category.find_by_id self.direct_parent_category_id
    end
  end            


  def parent_category_id_list 
    CategoryEdge.find(:all, :conditions => {
      :sub_category_id => self.id  
    }).collect {|x| x.category_id }
  end
    
    
=begin
  category creation
=end

  def self.create_root_category( params ) 
    # the absolute depth == 0 
    category = Category.new :title => params[:title], :description => params[:description]
    category.absolute_depth = ROOT_CATEGORY_ABSOLUTE_DEPTH
    category.is_root_category = true 
    category.save
    
    return category
  
  end
  
  def create_sub_category(params)
    category = Category.new :title => params[:title], :description => params[:description]
    category.absolute_depth = self.absolute_depth + 1  
    category.direct_parent_category_id = self.id
    category.save
    # category.propagate_edge_creation_to_the_root
    return category
  end
  
  
  protected
=begin
  Example case
  Have a look: Male, Female, Kids, Baby are all root categories 
  The category with depth 1 is  Top, Bottom, and Underwear
      category with depth 2 is Tshirt, shirt, singlet
      Category with depth 3 is turtle neck, v-neck

  Suppose that we are adding another category with depth 4
      Variation of Turtle Neck : Maldive Turtle and China Turtle 
      For the Maldive Turtle 
        It will create 
          1 edge linking Turtle Neck and Maldive Turtle ( delta == 1 )
          1 edge linking T-shirt and Maldive Turtle   ( delta == 2 )
          1 edge linking Top and Maldive Turtle 
          1 edge linking Male and Maldive Turtle 

        Number of edges created: total depth .. linear expansion. can we cater for this? ahaha

  Male    -> Top    -> T-Shirt  -> Turtle Neck   -> [ Maldive Turtle ]
                                -> V Neck
                    -> Shirt    -> Skinny
                                -> Loose
                    -> Singlet
          -> Bottom
          -> Underwear
  Female
  Kids 
  Baby 
=end
  def propagate_edge_creation_to_the_root
    if self.is_root_category == true 
      return
    end

    direct_parent = self.direct_parent_category
    
    # add the link ups with the direct parent's parents
    direct_parent.parent_category_id_list.each do |parent_category_id|
      parent_category = Category.find_by_id parent_category_id 
      
      CategoryEdge.create :category_id => parent_category_id , 
              :sub_category_id => self.id ,
              :delta => self.absolute_depth - parent_category.absolute_depth
    end
    
    # add the last link up with the direct parent
    CategoryEdge.create :category_id => direct_parent.id , 
            :sub_category_id => self.id ,
            :delta => self.absolute_depth - direct_parent.absolute_depth
  end

  def propagate_edge_deletion_to_the_root
    if self.is_root_category == true
      return 
    end
    
    CategoryEdge.find(:all, :conditions => {
      :category_id => self.parent_category_id_list,
      :sub_category_id => self.id 
    }).each {|x| x.destroy }
  end
    
end
