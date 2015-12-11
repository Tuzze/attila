require 'pg'

module Attila::DataLayer

class PostGres

  def initialize(params={})
    connect(params)
  end

  def connect(params={})
   if params != {} && params != @parameters && !params.nil?
    close
    @parameters = params
    @connection = PG::Connection.new(params)
   end
  end

  def retrieveTable(params={})
    @connection.exec(params[:query])
  end

  def transferTable(params={})
    source = PostGres.new(params[:source])
    rows = source.retrieveTable(query: params[:source_query])
    createTable(fields: rows.fields, table_name: params[:target_table])
    rows.each{ |r| rowInsert(params[:target_table], r) }
  end

  def rowInsert(table,row)
    r = row.select{|_,v| !v.nil?}
    @connection.exec("INSERT INTO #{table}(#{r.keys.join(",")}) VALUES(#{r.values.map{|v| "'#{@connection.escape_string(v)}'"}.join(",")})")
  end

  def createTable(params={})
    default_types = {}
    params[:fields].each { |f| default_types[f] = "VARCHAR" }
    types = default_types.merge( params[:types].nil? ? {}: params[:types] )
    @connection.exec("CREATE TABLE IF NOT EXISTS #{params[:table_name]} ( #{params[:fields].map{ |f| "#{f} #{types[f]}" }.join(",")} )")
  end

  def close
    if @connection
      @connection.close
    end
  end

  def query(q)
    @connection.exec(q)
  end

end

end