<?php
class Follow extends Auth {

	/*private $id_follower;
	private $id_following;*/
	
	public function __construct($session, $id_following = null, $options = []) {
		parent::__construct($session, $options = []);
		/*$this->id_follower = $session->id_user;
		$this->id_following = $id_follower;*/
	}

	public function countFollower($db, $user_id) {
        return $db->query('SELECT COUNT(id_user) AS count_follower FROM followers WHERE id_user = ? AND date_follow > 0', [$user_id])->fetch();
    }

    public function countFollowing($db, $user_id) {
        return $db->query('SELECT COUNT(id_follower) AS count_following FROM followers WHERE id_follower = ? AND date_follow > 0', [$user_id])->fetch();
    }


    public function listFollowing($db, $user_id) {
        return $db->query('SELECT users.*, followers.*, followers.id_user AS profil FROM users LEFT JOIN followers
            ON users.id_user = followers.id_user WHERE followers.id_follower = ? AND followers.date_follow > 0', [$user_id])->fetchAll();
    }



    public function listfollower($db, $user_id) {
        return $db->query('SELECT users.*, followers.*, followers.id_follower AS profil FROM users LEFT JOIN followers
            ON followers.id_follower = users.id_user WHERE followers.id_user = ? AND followers.date_follow > 0', [$user_id])->fetchAll();
    }


    
    public function isFollow($db, $getId, $user_id) {
        if($db->query('SELECT id_user FROM followers WHERE id_user = ? AND id_follower = ? AND date_follow > 0', [$getId, $user_id])->fetch()) {
            return 1;
        }
    }

    public function AllNotify($db, $user_id) { // table id notif 
        return $id_notif = $db->query('SELECT * FROM notifications WHERE id_user = ? AND status = 0 ORDER BY date_notif DESC', [$user_id])->fetchAll();
    }

    public function notif_type($db, $id_notif, $type) {
        // follow
        $notif = '';
        if($type == '1') {
            $info_follow = $this->checkId($db, $id_notif);
            return $notif = '<div class="notif_follow"><a href="profil.php?id='.$info_follow->id_user.'"><img src="'.$info_follow->avatar.'" alt="'.$info_follow->username.'"/><h2>@'.$info_follow->username.'</h2><p>vous suit, vous pouvez cliquer ici pour voir son profil.</p></a></div>';
            // fonction recup info style pour cette notif       
        }
        //reponse tweet ou retweet
        elseif($ype == '2') {
            return $db->query('SELECT * FROM tweets WHERE id_user = ?', [$id_notif])->fetch();
        } 
    }

    public function notify($db, $getId, $type, $id_notif) {

        $db->query('INSERT INTO notifications SET id_user = ?, type = ?, id_notif = ?, status = 0, date_notif = NOW()', [
            $getId, 
            $type,
            $id_notif
            ]);  
    }

    public function viewnotif($db, $user_id) {
        $db->query('UPDATE notifications SET status = 1 WHERE id_user = ?', [$user_id]);
    } // Quand ira ds l'onglet notif

    public function toFollow($db, $getId, $user_id) {
        if(!intval($getId))  { return false; }
        $contact = $db->query('SELECT * FROM followers WHERE id_user = ? AND id_follower = ?', [$getId, $user_id])->fetch();
        if(!$contact) {
            $db->query('INSERT INTO followers SET id_user = ?, id_follower = ?, date_follow = NOW()', [$getId, $user_id]);
            $this->notify($db, $getId, '1', $user_id);
        }
        else {
            if($contact->date_follow == 0) {
                $db->query('UPDATE followers SET date_follow = NOW() WHERE id_user = ? AND id_follower = ?', [$getId, $user_id]);
            }
        }
    }

    public function unFollow($db, $getId, $user_id) {
        if(!intval($getId))  { 
            return false; 
        }
        $contact = $db->query('SELECT * FROM followers WHERE id_user = ? AND id_follower = ?', [$getId, $user_id])->fetch();
        if($contact) {
            $db->query('UPDATE followers SET date_follow = NULL WHERE id_user = ? AND id_follower = ?', [$getId, $user_id]);
        }
    }


    public function display($db, $list) {

        $profil_following = '';

        foreach ($list as $info_user) {
           // var_dump($info_user);die;

            $profil_following .=
        '<div class="result-user">
            <div class="result-user-cover">
                <a href="profil.php?id='.$info_user->profil.'" title="'.$info_user->username.'"><img src="'.$info_user->cover.'" alt="'.$info_user->username.'"></a>
            </div>
            <div class="dashboard-data">
                <a href="profil.php?id='.$info_user->profil.'" title="'.$info_user->username.'"><img src="'.$info_user->avatar.'" alt="'.$info_user->username.'"></a>
               

                </div>
            <div class="dashboard-user">
                <a href="profil.php?id='.$info_user->profil.'" title="'.$info_user->username.'">'.ucfirst($info_user->nickname).'</a>
                <a href="profil.php?id='.$info_user->profil.'" title ="">@'.$info_user->username.'</a>
            </div>
            <div class="dashboard-stats">
                <div class="search-about-user">
                    <a title="Tweets" href="profil.php?id='.$info_user->profil.'">
                        <span class="describ-stats">À propos : </span>
                        <span class="biography-search">'.$info_user->biography.'</span>
                    </a>
                </div>
            </div>
        </div>';
        }

        return $profil_following;
    }
}