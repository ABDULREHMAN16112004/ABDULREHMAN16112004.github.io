<?php
session_start();
require_once('loader.inc');
require "PHPMailer/PHPMailerAutoload.php";

//PHP EMAILER FUNCTION START
 
    //PHP EMAILER FUNCTION END
    if(isset($_POST['forgotmob']))
   {
    $find_user= find("first", USERS, '*', "WHERE ( email='".$_POST['forgotmob']."')", array());
 
        if( $find_user)
        {
               
            if($find_user['status']=='active')
            {
                $four_digit_random_number = mt_rand(1000, 9999);
                $pass=substr($find_user['email'], 0, 3);
                $password=$pass.$four_digit_random_number;
                
                $table=USERS;
            	$set_value="password=:password";
            	$where_clause="WHERE id=".$find_user['id'];
            	$execute=array(
            
            	':password'=>$password
            	);
            	$update=update($table, $set_value, $where_clause, $execute);
            	if($update)
            	{
                    //EMAIL 
                    $to = $find_user['email'];
                    $from = 'info@tanzaniamarketplace.com';
                    $name = 'All States Marketplace';
                    $subj = 'Verified Your Account-All States Marketplace';
                    
                    $msg = '<div style="font-family: Helvetica,Arial,sans-serif;min-width:1000px;overflow:auto;line-height:2">
                    <div style="margin:50px auto;width:70%;padding:20px 0">
                    <div style="border-bottom:1px solid #eee">
                    
                     <a href="" style="font-size:1.4em;color: #00466a;text-decoration:none;font-weight:600"><img src="'.DOMAIN_NAME_PATH_ADMIN.'admin-login\images\logo\allstates_admin_logo.png" height="50px" /></a>
                        </div>
                        <p style="font-size:1.1em">Hi,</p>
                        <p> Welcome to All States Marketplace! Your Reset Password is- '.$password.'</p>
                        <p style="font-size:0.9em;">Regards,<br />All States Marketplace</p>
                        <hr style="border:none;border-top:1px solid #eee" />
                        <div style="float:right;padding:8px 0;color:#aaa;font-size:0.8em;line-height:1;font-weight:300">
                          <p>All States Marketplace</p>
                        </div>
                      </div>
                    </div>';
                    $error=smtpmailer($to,$from, $name ,$subj, $msg);
                    if($error)
                    {
                       echo('done');
                		exit;
                    }
            		else
            		{
            			echo("error occured");exit;
            		}
            	}
            }
            else
            {
                echo('not active');
                exit;
            }
        }
        else
        {
            echo('email not register');
             exit;
        }
   }
    else
  {
    echo('no');
    exit;
  }
