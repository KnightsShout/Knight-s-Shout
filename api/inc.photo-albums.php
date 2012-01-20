<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class PhotoAlbums
{
        private $m;
        private $db;
        
        function PhotoAlbums ($m)
        {
                $this->m = $m;
                $this->db = new Database ();
                
                define ('PHOTO_ALBUM_T_MEMBER', 1);
                define ('PHOTO_ALBUM_T_SERVER', 2);
                define ('PHOTO_T_MEMBER', 1);
                define ('PHOTO_T_SERVER', 2);
        }
        
        function getDb ()
        {
                return $this->db;
        }
        
        function createAlbum ($type, $feed = 1, $name = null, $is_standart = 0, $creator = null)
        {
                if ($creator === null)
                        $creator = $_SESSION['strAccount'];
                $time = time ();
                
                $this->db->doQuery ("INSERT INTO PHOTO_ALBUMS (nType, nIsStandart, strCreator, tAlbumName, dDate) VALUES (%u, %u, '%s', '%s', %u)", $type, $is_standart, $creator, $name, $time);
                if ($feed)
                {
                        $this->db->doQuery ("SELECT idPHOTO_ALBUMS FROM PHOTO_ALBUMS WHERE nType = %u AND nIsStandart = %u AND strCreator = '%s' AND tAlbumName = '%s' AND dDate = '%s'", $type, $is_standart, $creator, $name, $time);
                        $album = $this->db->doRead ();
                        $id = $album['idPHOTO_ALBUMS'];
                        $this->m->feeds->addFeed (FEED_T_CREATED_PHOTO_ALBUM, "$type,$creator,$id", $creator, $time);
                }
        }
        
        function removeAlbum ($id)
        {
                $this->db->doQuery ("DELETE FROM PHOTO_ALBUMS WHERE idPHOTO_ALBUMS = %u", $id);
                $this->db->doQuery ("DELETE FROM PHOTOS WHERE nAlbum = %u", $id);
        }
        
        function addPhoto ($type, $album, $desc = null, $is_standart = 0, $owner = null)
        {
                if ($owner === null)
                        $owner = $_SESSION['strAccount'];
                
                return $this->db->doQuery ("INSERT INTO PHOTOS (nType, nIsStandart, strOwner, tDescription, strResource, dDate) VALUES (%u, %u, '%s', '%s', '%s', %u)", $type, $is_standart, $owner, $desc, $resource, time ());
        }
        
        function removePhoto ($id)
        {
                $this->db->doQuery ("DELETE FROM PHOTOS WHERE idPHOTOS = %u", $id);
        }
}
?>