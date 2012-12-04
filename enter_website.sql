create or replace procedure enter_website(
											uname_input in users.uname%type,
											pname_input in pages.pname%type)
as

-- DECLARATIONS
userExists boolean;
userCount number;
userIsActive number;


pageExists boolean;
pageCount number;

num_visits number;
num_entrances number;

begin
	dbms_output.enable;

	select count(*) into userCount from users where uname = uname_input;
	select count(*) into pageCount from pages where pname = pname_input;
	select users.isActive into userIsActive from users where users.uname = uname_input;


	if ( userCount = 0 ) then
		userExists := FALSE;
	else
		userExists := TRUE;
	end if;

	if ( pageCount = 0 ) then
		pageExists := FALSE;
	else
		pageExists := TRUE;
	end if;

	--IF user && page exists
	if ( pageExists AND NOT userExists ) then
	--then
		dbms_output.put_line('User does not exist and page exists');
	--insert user to users values (uname_input, ++num_visits, pname_input)
		num_visits := 1;
		insert into users values(uname_input, num_visits, pname_input, 1);
	--update pages: where pname ++num_entrances;
		update pages set pages.num_entrances = pages.num_entrances + 1 where pages.pname = pname_input;
	elsif ( pageExists AND userExists ) then
		dbms_output.put_line('User and page already exists');
		--User was previously inactive
		if ( userIsActive = 0 ) then
			update users set users.num_visits = users.num_visits + 1 where users.uname = uname_input;
			--update pages: where pname ++num_entrances;
			update pages set pages.num_entrances = pages.num_entrances + 1 where pages.pname = pname_input;
		end if;
	end if;
	
end;
/