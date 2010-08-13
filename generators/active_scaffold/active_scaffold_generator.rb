require 'pp'
require 'facets/string/indent'

module Rails
  module Generator
    module Commands
      class Base
        # Based in part on http://stackoverflow.com/questions/956723/generating-nested-routes-in-a-custom-generator
        def route_namespaced_resources(namespace, resources, options)
          namespaces = namespace.split('/')
          resource_list = resources.map { |r| r.to_sym.inspect }.join(', ')
          sentinel = 'ActionController::Routing::Routes.draw do |map|'
          logger.route "#{namespace}.resources #{resource_list}"
          unless options[:pretend]
            gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
              "#{match}\n" +
              route_namespace_string('map', namespaces, 1) do |namespace, _namespaces, depth|
                "#{namespace}.resources #{resource_list}#{", #{options.inspect}" if options.any?}\n".indent(depth*2)
              end
            end
          end
        end

      private
        def route_namespace_string(outer_namespace, namespaces, depth, &block)
          namespace = namespaces.shift
          "#{outer_namespace}.namespace(:#{namespace}) do |#{namespace}|\n".indent(depth*2) +
            if namespaces.any?
              route_namespace_string(namespace, namespaces, depth+1, &block)
            else
              yield(namespace, namespaces, depth+1)
            end +
          "end\n".indent(depth*2)
        end
      end
    end
  end
end


class ActiveScaffoldGenerator < Rails::Generator::NamedBase
  attr_reader :controller_superclass, :model
  attr_reader :column_names

  def manifest
    @controller_superclass = Admin::BaseController
    @model = class_name.gsub(/(\w+::)*/, '').singularize.constantize

    column_names = @model.column_names.map(&:to_sym)
    association_names = @model.reflections.keys.map(&:to_sym)
    @column_names = column_names + association_names
    # Move some columns to the end, including all timestamps
    [:created_at, :updated_at].each do |column_name|
      if @column_names.delete column_name
        @column_names << column_name
      end
    end
    @column_names.dup.each do |column_name|
      if column_name.to_s =~ /_at$|_on$/ and @column_names.delete column_name
        @column_names << column_name
      end
    end

    namespace = class_name.underscore[ 0...(class_name.underscore.rindex( '/' ) || 0)]

    record do |m|
      m.template 'active_scaffold_controller.rb',
                  File.join('app/controllers',
                            class_path,
                            "#{file_name}_controller.rb")

      m.route_namespaced_resources namespace, [@model.name.pluralize.underscore], :active_scaffold => true
    end
  end
end
