create or replace procedure add_link(
										fpname_input in pages.pname%type,
										tpname_input in pages.pname%type
									)
	as

	-- DECLARATIONS
	fpageCount number;
	tpageCount number;
	fpageExists boolean;
	tpageExists boolean;

	linkCount number;
	linkExists boolean;

	begin
		dbms_output.enable;

		select count(*) into fpageCount from pages where pname = fpname_input;
		select count(*) into tpageCount from pages where pname = tpname_input;
		select count(*) into linkCount from links where fpname = fpname_input and tpname = tpname_input;


		--check if pname and tname exist
		if ( fpageCount = 0 ) then
			fpageExists := FALSE;
		else
			fpageExists := TRUE;
		end if;

		if ( tpageCount = 0 ) then
			tpageExists := FALSE;
		else
			tpageExists := TRUE;
		end if;

		--check if link exists
		if ( linkCount = 0 ) then
			linkExists := FALSE;
		else
			linkExists := TRUE;
		end if;

		if ( linkExists ) then
			dbms_output.put_line('Link already exists');
		elsif ( fpageExists AND tpageExists ) then
		--add link
			insert into links values(fpname_input, tpname_input, 0);
		else
			dbms_output.put_line('Page(s) do not exist');
		end if;


	end;
	/