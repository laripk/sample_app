
- exercises at end of ch 11

1. (challenging) Add a JavaScript display to the Home page to count down from 140 characters. 

2. Add tests for the sidebar micropost counts (including proper pluralization). 

3. (mainly for designers) Modify the microposts listing to use an ordered list instead of a table. (Note: this is how Twitter displays its status updates.) Then add the appropriate CSS to make the resulting feed not look like crap. 

4. Add tests for micropost pagination. 

5. Refactor the Home page to use separate partials for the two branches of the if-else statement. 

6. Write a test to make sure delete links do not appear for microposts not created by the current user. 

7. Add a nested route so that /users/1/microposts shows all the microposts for user 1. (You will also have to add a Microposts controller index action and corresponding view.) 

8. Very long words currently break our layout, as shown in Figure 11.17. Fix this problem using the wrap helper deﬁned in Listing 11.42. (Note the use of the raw method to prevent Rails from escaping the resulting HTML, together with the sanitize method needed to prevent cross-site scripting.) 



- chapter 12 exercises and extension suggestions

-- exercises

1. Add tests for dependent :destroy in the Relationship model (Listing 12.5 and Listing 12.17) by following the example in Listing 11.11. 

2. The respond_to method seen in Listing 12.36 can actually be hoisted out of the actions into the Relationships controller itself, and the respond_to blocks can be replaced with a Rails method called respond_with. Prove that the resulting code, shown in Listing 12.46, is correct by verifying that the test suite still passes. (For details on this method, do a Google search on “rails respond_with”.) 

3. The following and followers actions in Listing 12.29 still have considerable duplication. Verify that the show_follow method in Listing 12.47 eliminates this duplication. (See if you can infer what the send method does, as in, e.g., @user.send(:following).) 

4. Refactor Listing 12.30 by adding partials for the code common to the following/followers pages, the Home page, and the user show page. 



-- extension suggestions

--- replies

--- direct messaging

--- follower notifications

--- password reminders

--- signup email confirmation

--- rss feed

--- rest api

--- search - users, microposts








