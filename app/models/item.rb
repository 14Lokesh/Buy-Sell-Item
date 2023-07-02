class Item < ApplicationRecord
    belongs_to :category
    belongs_to :user
    has_many :reviews
    has_many_attached :images, :dependent => :destroy
    validates :title ,:description,:phone,:username,:city, presence: true
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    settings do
        mappings dynamic: false do           
            indexes :title , type: :text, analyzer: :english
            indexes :city , type: :text, analyzer: :english
            indexes :description , type: :text, analyzer: :english
            indexes :approved , type: :boolean, analyzer: :english
            indexes :username , type: :text, analyzer: :english
            indexes :category , type: :keyword
        end
    end

    def as_indexed_json(options = {}){
        id: id,
        title: title,
        city: city,
        description: description,
        approved: approved,
        username: username,
        category: category.category
        }
   end

    # def self.search_data(query1, query2)
    #     search({
    #       query: {
    #         bool: {
    #           must: [
    #             {
    #               exists: {
    #                 field: "title"
    #               }
    #             },
    #             {
    #               exists: {
    #                 field: "city"
    #               }
    #             },
    #             {
    #               bool: {
    #                 should: [
    #                   {
    #                     match: {
    #                       title: {
    #                         query: query1,
    #                         operator: "and"
    #                       }
    #                     }
    #                   },
    #                   {
    #                     match: {
    #                       city: {
    #                         query: query2,
    #                         operator: "or"
    #                       }
    #                     }
    #                   }
    #                 ]
    #               }
    #             }
    #           ]
    #         }
    #       }
    #     })
    #   end
      
      
    

    
    
    
    
    
    



      
      
    # def self.search_data(query)
    #   search({
    #              query: {
    #                    multi_match: {
    #                       query: query,
    #                       fields: ['title', 'city', 'category']
    #                       }
    #                  }       
            
    #           })
    # end
   
 
# def self.search_data(query, category)
#   search({
#     query: {
#       bool: {
#         must: [
#           {
#             multi_match: {
#               query: query,
#               fields: ['title', 'city']
#             }
#           },
#           {
#             term: {
#               category: category
#             }
#           }
#         ]
#       }
#     }
#   })
# end


  

end


