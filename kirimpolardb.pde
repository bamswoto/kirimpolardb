// Impor JDBC driver untuk PostgreSQL
import java.sql.*;

// Deklarasikan variabel global untuk koneksi, statement, dan sql
Connection conn;
Statement stmt;
String sql;

// Fungsi void setup() untuk mengatur program
void setup() {
  // Tentukan ukuran jendela
  size(640, 360);

  // Buat koneksi ke database PolarDB PostgreSQL
  String url = "jdbc:postgresql://megatroll.rwlb.ap-southeast-5.rds.aliyuncs.com:1921/appwebp5js";
  String user = "p5js_db";
  String password = "bambang86!";

  try {
    conn = DriverManager.getConnection(url, user, password);
    // Buat objek Statement untuk menjalankan perintah SQL
    stmt = conn.createStatement();
    // Buat tabel contoh di database PolarDB PostgreSQL
    //sql = "CREATE TABLE example (id INT, name VARCHAR(20), age INT)";
    //stmt.executeUpdate(sql);
  } 
  catch (Exception e) {
    // Tangani pengecualian
    e.printStackTrace();
  }
}

// Fungsi void draw() untuk menggambar program
void draw() {
  // Masukkan data ke tabel contoh

  try {
    //sql = "INSERT INTO datakuoke (id, uraian) VALUES (2, 'Alice')";
    //stmt.executeUpdate(sql);
    //sql = "INSERT INTO datakuoke (id, uraian) VALUES (3, 'Bob')";
    //stmt.executeUpdate(sql);
    //sql = "INSERT INTO datakuoke (id, uraian) VALUES (4, 'Charlie')";
    //stmt.executeUpdate(sql);
    
    sql = "DELETE FROM datakuoke WHERE ID = 4";
    stmt.executeUpdate(sql);
    

    // Tutup objek Statement dan koneksi
    stmt.close();
    conn.close();
  } 
  catch (Exception e) {
    // Tangani pengecualian
    e.printStackTrace();
  }

  // Hentikan program
  noLoop();
}
