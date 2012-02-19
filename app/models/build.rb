class Build 
  
  attr_reader :items
  attr_reader :total_price
  
  def initialize
    empty_all_items
  end
  
  def empty_all_items
    @items = []
    @total_price = 0.0
  end

  def add_frame_to_build (frame, frame_size, gear, top_tube_style)
      existing_frame = @items.find {|item| (item.frame_model)}
      existing_custom_model = @items.find {|item| (item.custom_frame_model)}
      if existing_frame
        @items.delete(existing_frame)
        @items << CustomerBuildItem.new_frame_based_on(frame, frame_size, gear, top_tube_style)
      elsif existing_custom_model
        @items.delete(existing_custom_model)
        @items << CustomerBuildItem.new_frame_based_on(frame, frame_size, gear, top_tube_style)
      else
        @items << CustomerBuildItem.new_frame_based_on(frame, frame_size, gear, top_tube_style)
      end
      @total_price += (frame.price + frame_size.price + gear.price + top_tube_style.price)
  end
  
  def add_custom_frame_to_build (frame)
      existing_frame = @items.find {|item| (item.frame_model)}
      if existing_frame
        @items.delete(existing_frame)
        @items << CustomerBuildItem.new_custom_frame_based_on(frame)
      else
        @items << CustomerBuildItem.new_custom_frame_based_on(frame)
      end
  end
  
  def add_custom_component_to_build (component)
        existing_component = @items.find {|item| (item.component && (item.component.component_type == component.component_type))}
        existing_custom_component = @items.find {|item| (item.custom_component && (item.component_type == component.component_type))}
        if existing_component
          @items.delete(existing_component)
          @total_price -= (existing_component.price)
          @items << CustomerBuildItem.new_build_custom_component_based_on(component)
        elsif existing_custom_component
          @items.delete(existing_custom_component)
          @items << CustomerBuildItem.new_build_custom_component_based_on(component)
        else
          @items << CustomerBuildItem.new_build_custom_component_based_on(component)
        end
        #@total_price += (component.price)
  end

  def add_component_to_build (component)
      existing_component = @items.find {|item| (item.component && (item.component.component_type == component.component_type))}
      existing_custom_component = @items.find {|item| (item.custom_component && (item.custom_component.component_type == component.component_type))}
      if existing_component
        @items.delete(existing_component)
        @total_price -= (existing_component.price)
        @items << CustomerBuildItem.new_build_component_based_on(component)
      elsif existing_custom_component
        @items.delete(existing_custom_component)
        @items << CustomerBuildItem.new_build_component_based_on(component)
      else
        @items << CustomerBuildItem.new_build_component_based_on(component)
      end      
      @total_price += (component.price) 
  end
   
  def remove_component_from_build(component)
    existing_component = @items.find {|item| (item.component && (item.component.component_type == component.component_type))}
    @items.delete(existing_component)
    @total_price -= component.price
  end
  
   def remove_custom_component_from_build(component_type)
     existing_custom_component = @items.find {|item| (item.custom_component && (item.custom_component.component_type == component_type))}
     @items.delete(existing_custom_component)
   end

  def remove_compartment_from_build(items_to_delete)
     items_to_delete.each do |item|
        @items.delete(item)
        if item.component
        @total_price -= item.price
        end
     end
  end

end
