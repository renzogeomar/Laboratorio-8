#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use CGI::Carp 'fatalsToBrowser';

# Crear objeto CGI
my $q = CGI->new();
print $q->header('text/html; charset=UTF-8');

# Obtener los parámetros enviados desde el formulario
my $titulo = $q->param('titulo');
my $contenido = $q->param('contenido');
my $ruta = $q->param('ruta');

# Ruta al archivo de datos
my $data_file = "/var/www/html/pages/pages_data.txt";
my @lines;

# Leer el archivo y actualizar el contenido de la página
open my $fh, '<', $data_file or die "No se puede abrir el archivo de datos: $!";
while (my $line = <$fh>) {
    chomp $line;
    my ($titulo_file, $contenido_file, $ruta_file) = split /\|/, $line;

    # Si encontramos la página, actualizamos su contenido
    if ($titulo eq $titulo_file) {
        $line = "$titulo|$contenido|$ruta"; # Actualizar línea con nuevo contenido
    }
    push @lines, $line;
}
close $fh;

# Escribir los cambios en el archivo
open my $fh_out, '>', $data_file or die "No se puede abrir el archivo para escribir: $!";
foreach my $line (@lines) {
    print $fh_out "$line\n";
}
close $fh_out;

# Redirigir al listado de páginas
print "<h1>Página actualizada correctamente.</h1>";
print "<br><a href='/cgi-bin/list.pl'>Regresar al listado de páginas</a>";