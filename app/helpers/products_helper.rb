module ProductsHelper
    def current_category(cate_id)
      @current_category ||= find_category(cate_id)
    end

    # def current_gender(gender)
    #   render=''
    #   if gender === 1
    #      render = 'MEN'
    #   else
    #      render = 'WOMEN'
    #   end
    #   render
    # end
    def find_category(cate_id)
      category = Category.find_by(id: cate_id).name
    end


end
