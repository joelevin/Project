create or replace procedure exit_website(uname_input in users.uname%type)
	as

-- DECLARATIONS
userExists boolean;
userIsActive number;
userCount number;

pageExists boolean;
pageCount number;

begin
	dbms_output.enable;

	select count(*) into userCount from users where uname = uname_input;
	select users.isActive into userIsActive from users where users.uname = uname_input;

	if ( userCount = 0 ) then
		userExists := FALSE;
	else
		userExists := TRUE;
	end if;
	

	--if user exists
	if ( userExists ) then
		--check if user is active
		if ( userIsActive = 1 ) then
		--user deactivate
			update users set users.isActive = 0 where users.uname = uname_input;
	--update pages: where pname ++num_exits
			update pages set pages.num_exits = pages.num_exits + 1 where pages.pname = (select pname from users where users.uname = uname_input);
		end if;
	end if;
end;
/