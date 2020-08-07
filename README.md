# COV-HELP

Covid Plasma Donation App

The app focuses on providing Plasma donation facility to people who have recovered from COVID 19. 

# Main Components on Sign Up:- 

# 1) Email ID and phone number verfication
# 2) Blood group Collection

The database has a parent node "Users" in which the user is assigned a UID and this is used to store the information for the patient.

On signing in the app shows you the live no. of cases in various states and the conditions to required for you to be a valid donor. 
The UI is very user friendly which can be seen through the screenshots in the screen shots folder.

A Donate now option is given in this page which takes you to the screen which takes care of the necessary conditions for Plasma donation.

# The next page has two options:-

# 1) to register the user (we contact the user when plasma is needed in that district)
# 2) Donate at the Plasma Bank now.(Incase your city has a plasma bank, you can schedule an appointment to donate)

On registration you are registered as a donor in that district which is visible to the hospitals where plasma therapy is available through the website designed.

On scheduling an appointment you get an option to view and cancel the appointment before 24 hrs of the booking.

The Database design (JSON tree structure) is as follows and carries all operations in O(1) time.

Users:
  uid:
    name: Gaurav
    blood_group: B+
    state:  XYZ
    district: ABC
    phone_no: 0987654321
    email: abc@mail.com
    time:1-3PM
    date: 20-08-2020
    hid: hospital_id_1
Donors:
  State1:
    District1: 
      uid1
      uid2
  State2:
    District2:
      uid3
      uid4
User_list:
  hid1:
    uid1
    uid2
    uid3
  hid2:
    uid4
    uid5
    
    
      
    
