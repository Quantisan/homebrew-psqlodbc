require 'formula'

class Psqlodbc < Formula
  homepage 'http://psqlodbc.projects.pgfoundry.org/'
  url 'http://ftp.postgresql.org/pub/odbc/versions/src/psqlodbc-08.04.0200.tar.gz'
  sha1 '2d7aab39a77fbd65b25218f07b02d913cec80eb6'
  
  depends_on "postgresql"
  depends_on "unixodbc" => :optional
  depends_on "libiodbc" => [:optional, 'with-iodbc']

  def install
    args = ["--disable-dependency-tracking", "--prefix=#{prefix}", "--enable-pthreads"]
    args << "--with-libpq=#{Formula.factory('postgresql').lib}"
    
    if build.include? "disable-unicode"
      args << "--disable-unicode"
    end
    
    if build.include? "with-iodbc"
      args << "--with-iodbc=#{Formula.factory('libiodbc').prefix}"
    end
    if build.include? "with-unixodbc"
      args << "--with-unixodbc=#{Formula.factory('unixodbc').prefix}"
    end
    
    system "./configure", *args

    system "make"
    system "make", "install"
  end
end
