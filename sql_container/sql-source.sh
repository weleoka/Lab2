sql-container()
{
  apt update
  apt install -y git
  git clone https://github.com/ToddBooth/Testing-IT-Systems-Lab-2
  cd Testing-IT-Systems-Lab-2
  apt install -y mysql-client
}

my()
{
  echo "To initialize the SQL Test Data via a MySQL script, enter source test_data_1.sql"
  mysql -ppw
}
