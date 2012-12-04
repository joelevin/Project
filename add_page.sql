create or replace procedure add_page(pname_input in pages.pname%type)
	as

	pageCount number;

	begin
		dbms_output.enable;

		select count(*) into pageCount from pages where pname = pname_input;

		dbms_output.put_line(pageCount);

		if (pageCount = 0) then
			insert into pages values(pname_input, 0, 0);
			commit;
		else
			dbms_output.put_line('Page already exists');
		end if;

	end;
	/