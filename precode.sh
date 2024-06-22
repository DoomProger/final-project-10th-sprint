#!/bin/bash

# создаём каталог task с вложенными директориями
# task
#   dir1
#   dir2
#   dir3
#       dir4
mkdir -p task/dir{1,2,3}
mkdir -p task/dir3/dir4

# изменяем текущую директорию на task
cd task 

# создаём пустой файл task/dir2/empty
touch dir2/empty

# создаём файл task/dir2/hello.sh с таким содержанием:
# #!/bin/bash
# echo "$1, привет!"
FILE_HELLO_PATH=dir2/hello.sh

cat <<EOF> $FILE_HELLO_PATH
#!/bin/bash
echo "\$1, привет!"
EOF

# устанавливаем для task/dir2/hello.sh права rwxrw-r--
chmod 764 $FILE_HELLO_PATH

# сохраняем список файлов task/dir2 в task/dir2/list.txt
FILE_LIST_PATH=dir2/list.txt
echo "$(ls dir2)" > $FILE_LIST_PATH

# копируем содержимое каталога task/dir2 в каталог task/dir3/dir4
cp -r dir2 dir3/dir4

# записываем в task/dir1/summary.txt список файлов с расширением *.txt
# находящихся в task, включая поддиректории
FILE_SUMMARY_PATH=dir1/summary.txt
find ./ -name "*.txt" > $FILE_SUMMARY_PATH

# дописываем в task/dir1/summary.txt содержимое task/dir2/list.txt
cat $FILE_LIST_PATH >> $FILE_SUMMARY_PATH

# определяем переменную окружения NAME со значением "Всем студентам"
NAME="Всем студентам"

# запускаем task/dir2/hello.sh с переменной окружения NAME в качестве аргумента
# вывод скрипта должен дописаться в файл task/dir1/summary.txt
./$FILE_HELLO_PATH $NAME >> $FILE_SUMMARY_PATH

# перемещаем с переименованием task/dir1/summary.txt в task/Практическое задание
mv $FILE_SUMMARY_PATH "Практическое задание"

# выводим на консоль содержимое файла task/Практическое задание
cat "Практическое задание"

# ищем в файле "Практическое задание" строки, которые содержат слово "dir"
# и затем отсортировываем их
grep dir "Практическое задание" | sort

# меняем текущую директорию на родительскую для task
cd ..

# удаляем директорию task со всем содержимым
rm -rf task/
