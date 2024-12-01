#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use utf8;
use CGI::Carp 'fatalsToBrowser';
use File::Basename;

# Crear un objeto CGI
my $q = CGI->new();

# Imprimir encabezados HTTP
print $q->header('text/html; charset=UTF-8');
print "<!DOCTYPE html>";
print "<html lang=\"es\">";
print "<head>";
print "<title>Listado de Páginas</title>";
print "<meta charset=\"UTF-8\">";
print "</head>";
print "<body>";
print "<h1>Listado de Páginas</h1>";

# Incluir un estilo básico para la tabla
print "<style>";
print "table {width: 100%; border-collapse: collapse;} ";
print "th, td {border: 1px solid #ddd; padding: 8px; text-align: left;} ";
print "th {background-color: #f2f2f2;} ";
print "</style>";

print "<table>";
print "<thead>";
print "<tr>";
print "<th>Nombre de la Página</th>";
print "<th>Acciones</th>";
print "</tr>";
print "</thead>";
print "<tbody>";

# Leer archivos en la carpeta pages/
my $directory = "/var/www/html/pages/";
opendir(my $dir, $directory) or die "No se pudo abrir el directorio: $!";
my @files = grep { /\.html$/ && -f "$directory/$_" } readdir($dir);
closedir($dir);

# Listar los archivos como hiperenlaces
foreach my $file (@files) {
    my $name = basename($file, ".html"); # Extraer el nombre base sin extensión
    print "<tr>";
    print "<td><a href='$directory/$file'>$name</a></td>"; # Enlace al archivo .html
    print "<td class='actions'>";
    print "<a href='edit.pl?file=$file' title='Editar'>E</a> ";  # Enlace para editar
    print "<a href='delete.pl?file=$file' title='Eliminar'>X</a>"; # Enlace para eliminar
    print "</td>";
    print "</tr>";
}

print "</tbody>";
print "</table>";
print "<a href='../new.html'>Crear Nueva Página</a>";
print "</body>";
print "</html>";