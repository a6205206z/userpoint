class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user_info_session, :current_user_info, :current_admin_session, :current_admin

  private

  def current_user_info_session
  	@current_user_info_session ||= UserInfoSession.find
  end

  def current_user_info
  	@current_user_info ||= current_user_info_session && current_user_info_session.record
  end

  def current_admin_session
    @current_admin_session ||= AdminSession.find
  end

  def current_admin
    @current_admin ||= current_admin_session && current_admin_session.record
  end

  def uploadFile(file , dir_path)    
     if !file.original_filename.empty?
       #生成一个随机的文件名      
       filename = getFileName(file.original_filename) 
       file_path = RAILS_ROOT << dir_path << filename   
       #向dir目录写入文件  
       File.open(file_path, "wb") do |f|
          f.write(file.read)
       end   
         #返回文件名称，保存到数据库中  
       return filename  
     end  
  end   
    
  def getFileName(filename)  
    if !filename.nil?  
     require 'uuidtools'  
       filename.sub(/.*./,UUIDTools::UUID.random_create.to_s+'.jpg')
     end  
  end  
end
