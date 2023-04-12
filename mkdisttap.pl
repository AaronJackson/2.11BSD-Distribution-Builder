#!/usr/bin/perl -w
use strict;

# Based on mkdisttap.pl
# ftp://ftp.mrynet.com/pub/os/PUPS/PDP-11/Boot_Images/2.11_on_Simh/211bsd/mkdisttap.pl

add_file("chunks/mtboot", 512);
add_file("chunks/mtboot", 512);
add_file("chunks/boot", 512);
end_file();
add_file("chunks/disklabel", 1024);
end_file();
add_file("chunks/mkfs", 1024);
end_file();
add_file("chunks/restor", 1024);
end_file();
add_file("chunks/icheck", 1024);
end_file();
add_file("root.dump", 10240);
end_file();
add_file("file6.tar", 10240);
end_file();
add_file("file7.tar", 10240);
end_file();
add_file("file8.tar", 10240);
end_file();
end_file();

sub end_file {
  print "\x00\x00\x00\x00";
}

sub add_file {
  my($filename, $blocksize) = @_;
  my($block, $bytes_read, $length);

  open(FILE, $filename) || die("Can't open $filename: $!");
  while($bytes_read = read(FILE, $block, $blocksize)) {
    if($bytes_read < $blocksize) {
      $block .= "\x00" x ($blocksize - $bytes_read);
      $bytes_read = $blocksize;
    }
    $length = pack("V", $bytes_read);
    print $length, $block, $length;
  }
  close(FILE);
}
