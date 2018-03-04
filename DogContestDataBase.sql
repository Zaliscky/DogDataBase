use master
ALTER DATABASE CourseWork SET SINGLE_USER WITH ROLLBACK IMMEDIATE

ALTER DATABASE CourseWork SET MULTI_USER
Drop Database CourseWork

create database CourseWork;
Use CourseWork;


create table Documents
(
registrationPK integer primary key, 
veterinarianConfirmation varchar(15) not null ,
registration varchar(50)  not null,
Invitation varchar(50)not null,

constraint veterinarian_chk check (veterinarianConfirmation='confirmed'  or veterinarianConfirmation='not confirmed' ),
constraint Documents_chk check (registration='performed'  or registration ='not performed' ),
constraint Invatation_chk check (Invitation='send'  or Invitation ='not send' )

)


create table Proprietor
(
Name varchar(50)  not null,
Surname varchar(50)  not null,
OwnerPK  integer primary key,
email varchar(50) unique not null,
telephone char(7) unique not null,
country varchar(50)  not null,
city varchar(50)  not null,
OwnerFK integer constraint "OwnerFK_Documents" foreign key("OwnerFK") references Documents(registrationPK)  on delete no action, 
);




create table Dog
(
"DogPK" integer primary key,
"DogFK" integer constraint "Dog_Owner" foreign key("DogFK") references Proprietor(OwnerPK)  on delete set null,
"Name" varchar(50) unique not null,
sex varchar(50) not null,
breed varchar(50) not null,
num int not null unique,
birth date not null,

constraint sex_chk check(sex='male' or sex ='female' or sex='boy' or sex='girl') 
);

create table DogCategory
(
dogweight int not null ,
dogsize int not null ,
dogage int not null ,
"DogCategoryFK" integer constraint "Dog_DogCategory" foreign key("DogCategoryFK") references Dog(DogPK)  on delete set null,
);


create table Awards
(
AwardPK integer primary key,
AwardName varchar(15),
Prize varchar(15),
Trophy varchar(15),

constraint AwardsName_chk check (AwardName = 'best puppy' or AwardName = 'best junior' or  AwardName = 'best veteran'),
constraint AwardsPrize_chk check (Prize = '1000000' or AwardName = '500000' or  AwardName = '2500000'   ),
constraint AwardsTrophy_chk check (Trophy = 'gold' or AwardName = 'silver' or  AwardName = 'bronze'   )

);

create table Assesment
(
juriPK integer primary key,
mark int,
"MarkFK" integer constraint "Dog_Mark" foreign key("MarkFK") references Dog(DogPK)  on delete set null,
"AssesmentFK" integer constraint "Assesment_Awards" foreign key("AssesmentFK") references Awards(AwardPK)  on delete no action,

constraint mark_chk check ("mark">=1 and "mark"<=10 )

);

create Table Examiner
(
"JuriFK" integer constraint "Juri_Assesment" foreign key("JuriFK") references Assesment(juriPK)  on delete set null,
"name" varchar(50)  not null,
"Surname" varchar(50)  not null,
email varchar(50) unique not null,
telephone char(7) unique not null
);



create table VeterinarianCheck
(
injection varchar(15) not null,
Form1 varchar(15) not null,
"veterinarianFK" integer constraint "veterinarian_CompatitionReg" foreign key("veterinarianFK") 
references  Documents(registrationPK)  on delete no action,

constraint registration_chk check (Form1='confirmed'  or Form1 ='not confirmed' ),
constraint injection_chk check (injection='performed'  or injection ='not performed' )
);

create table Registration
(
RegistrationPK integer primary key,
ContanstantNum int not null unique,
Ancestry varchar(50)  not null,
Payment varchar(50)  not null,

"RegistrationFK" integer constraint "Registration_CompatitionReg" foreign key("RegistrationFK") references  Documents(registrationPK)  on delete no action,
);


---------------------------------------------//// Organizer branches
create table ServingPanel
(
ServingPanelPK  integer primary key,
"Name" varchar(50)  not null,
"Surname" varchar(50)  not null,
"Post" varchar(15) not null,
"Tel" char(7) not null,
"Salary" int not null,
"Hiredate" date not null
);

create table EntertaingPanel
(
EntertaingPanelPK  integer primary key,
"Name" varchar(50)  not null,
"Surname" varchar(50)  not null,
"Post" varchar(15)not null,
"Tel" char(7)not null,
"Salary" int not null,
"Hiredate" date not null
);

create table SecurityPanel
(
SecurityPanelPK  integer primary key,
"Name" varchar(50)  not null,
"Surname" varchar(50)  not null,
"Post" varchar(15)not null,
"Tel" char(7)not null,
"Salary" int not null,
"Hiredate" date not null,
);

---------------------------------------------////
create table OrganizationPayment
(
OrganizationPaymentPK integer primary key,

Guard int not null,
Servicing int not null,
Entertaing int not null,
advertisment int not null,
place int not null,
food int not null

                                                      
);



create table Organizer
(
OrganizerPK  integer primary key,
"OrganizerFK" integer constraint "Registration_Organizer" foreign key("OrganizerFK") references  Registration(RegistrationPK)  on delete no action,
"Name" varchar(50)  not null,
email varchar(50) unique not null,
telephone char(7) unique not null,
OrganizationPaymentFK integer constraint "OrganizationPayment_organizer" foreign key("OrganizationPaymentFK") references   OrganizationPayment(OrganizationPaymentPK)  on delete no action,
OrganizerServingPanelFK integer constraint "OrganizerServingPanel" foreign key("OrganizerServingPanelFK") references   ServingPanel(ServingPanelPK)  on delete no action,
OrganizerEntertaingPanelFK integer constraint "OrganizerEntertaingPanel" foreign key("OrganizerEntertaingPanelFK") references  EntertaingPanel(EntertaingPanelPK)  on delete no action,
OrganizerSecurityPanelFK integer constraint "OrganizerSecurityPanel" foreign key("OrganizerSecurityPanelFK") references SecurityPanel(SecurityPanelPK)  on delete no action
);



create table CompetitionOrganization
(
CompetitionOrganizationPK  integer primary key,
CompetitionOrganizationFK integer constraint "Organizer_comporg" foreign key("CompetitionOrganizationFK") references  
                                                                    Organizer(OrganizerPK)  on delete no action,
Fund float not null,
Country varchar(20) not null ,
City varchar(20)  not null,
EstablishmentName varchar(50) not null,
TimeData date not null,
);


create table Sponsor
(
SponsorPK integer primary key,
"SponsorName" varchar(50)  not null,
email varchar(50) unique not null,
telephone char(7) unique not null,
"Name" varchar(50)  not null,
"Surname" varchar(50)  not null,
"Post" varchar(15) not null,
"Salary" int not null,
"Hiredate" date not null

);

create table Chiefs
(
"Name" varchar(50)  not null,
"Surname" varchar(50)  not null,
"Tel" char(7)not null,
"Salary" int not null,
"Hiredate" date not null,

ChiefsOgrganizaerFK integer constraint "ChiefsOrrganizar" foreign key("ChiefsOgrganizaerFK") references   Organizer(OrganizerPK)  on delete no action,
ChiefsServingPanelFK integer constraint "ChiefsrServingPanel" foreign key("ChiefsServingPanelFK") references   ServingPanel(ServingPanelPK)  on delete no action,
ChiefsEntertaingPanelFK integer constraint "ChiefsEntertaingPanel" foreign key("ChiefsEntertaingPanelFK") references  EntertaingPanel(EntertaingPanelPK)  on delete no action,
ChiefsSecurityPanelFK integer constraint "ChiefsSecurityPanel" foreign key("ChiefsSecurityPanelFK") references SecurityPanel(SecurityPanelPK)  on delete no action,
SponsorChiefFK integer constraint "SponsorFK_Chief" foreign key("SponsorChiefFK") references  
                                                                   Sponsor(SponsorPK )  on delete no action,
);



Use CourseWork
select SecurityPanel.Name as'name',
        SecurityPanel.Hiredate as 'Hiredate',
		SecurityPanel.Post as'post',
		SecurityPanel.Salary as'salary',
		SecurityPanel.Surname as'Surname'
		from SecurityPanel;

select * from INFORMATION_SCHEMA.COLUMNS
select * from INFORMATION_SCHEMA.CHECK_CONSTRAINTS
select * from INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
select * from INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE

select Chiefs.Name as 'Chiefs name', Chiefs.Surname as 'Chiefs surname' ,Chiefs.Salary  as 'Chiefs salary' 
 from Chiefs,SecurityPanel
 
 

 

